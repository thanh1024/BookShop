package com.example.bookshop.controller.admin;

import com.example.bookshop.domain.Book;
import com.example.bookshop.domain.Category;
import com.example.bookshop.domain.Review;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.CategoryService;
import com.example.bookshop.service.ReviewService;
import com.example.bookshop.service.UploadService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Controller
public class BookController {
    @Autowired
    private UploadService uploadService;

    @Autowired
    private BookService bookService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ReviewService reviewService;

    @GetMapping("admin/book")
    public String getBookPage(Model model, @RequestParam("page") Optional<String> optionalPage) {
        int page = 1;
        try {
            if (optionalPage.isPresent()) {
                page = Integer.parseInt(optionalPage.get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
        }
        Pageable pageable = PageRequest.of(page - 1, 2);
        Page<Book> arrBook = this.bookService.getAllProducts(pageable);
        List<Book> listBooks = arrBook.getContent();

        model.addAttribute("books", listBooks);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", arrBook.getTotalPages());
        return "admin/book/show";
    }

    @GetMapping("admin/book/create")
    public String getBookListPage(Model model) {
        model.addAttribute("newBook", new Book());
        model.addAttribute("categories", categoryService.findAll());
        return "admin/book/create";
    }

    @PostMapping("admin/book/create")
    public String createBookPage(Model model,
                                 @ModelAttribute("newBook") @Valid Book newBook,
                                 BindingResult bindingResult,
                                 @RequestParam("File") MultipartFile file) {

        // In ra lỗi nếu có
        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>> " + error.getField() + " - " + error.getDefaultMessage());
        }
        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", categoryService.findAll());
            return "admin/book/create";
        }

        // Lưu ảnh
        String imgPath = uploadService.handleSaveFile(file, "books");
        newBook.setImage(imgPath);

        // Lấy danh sách Category từ ID (nếu chỉ mới set ID trong form)
        Set<Category> categoryEntities = new HashSet<>();
        for (Category cat : newBook.getCategories()) {
            Category fullCategory = categoryService.getCategoryById(cat.getId());
            if (fullCategory != null) {
                categoryEntities.add(fullCategory);
            }
        }
        newBook.setCategories(categoryEntities);

        // Lưu book
        bookService.saveBook(newBook);

        return "redirect:/admin/book";
    }

    @GetMapping("admin/book/{id}")
    public String bookDetail(@PathVariable("id") Long id, Model model) {
        Book book = bookService.getBookById(id);
        if (book == null) {
            return "redirect:/admin/book";
        }
        model.addAttribute("book", book);
        return "admin/book/detail";
    }

    @GetMapping("admin/book/update/{id}")
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        Book book = bookService.getBookById(id);
        List<Category> categories = categoryService.findAll();

        model.addAttribute("bookUpdate", book);
        model.addAttribute("categories", categories);
        return "admin/book/update";
    }

    @PostMapping("admin/book/update")
    public String updateBook(@Valid @ModelAttribute("bookUpdate") Book book,
                             BindingResult result,
                             @RequestParam("File") MultipartFile file,
                             Model model) {
        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.findAll());
            return "admin/book/update";
        }
        Book book1 = bookService.getBookById(book.getId());
        String imgPath = uploadService.handleSaveFile(file, "books");
        if ( book1 != null) {
            book1.setImage(imgPath);
            book1.setName(book.getName());
            book1.setAuthor(book.getAuthor());
            book1.setPrice(book.getPrice());
            book1.setCategories(book.getCategories());
            book1.setDetailDesc(book.getDetailDesc());
            this.bookService.saveBook(book1);
        }

        return "redirect:/admin/book"; // quay lại danh sách
    }

    @GetMapping("admin/book/delete/{id}")
    public String showDeleteBookPage(@PathVariable("id") Long id, Model model) {
        Book book = bookService.getBookById(id);
        if (book == null) {
            return "redirect:/admin/book";
        }
        model.addAttribute("id", id);
        model.addAttribute("bookDelete", book);
        return "admin/book/delete";
    }

    @Transactional
    @PostMapping("admin/book/delete")
    public String deleteBook(@ModelAttribute("bookDelete") Book book) {
        // Xóa liên kết 2 chiều (nếu bạn có quan hệ 2 chiều trong Category)
        Book book1 = bookService.getBookById(book.getId());
        for (Category category : book1.getCategories()) {
            category.getBooks().remove(book1); // nếu có mappedBy trong Category
        }

// Xóa tất cả liên kết với Category
        book1.getCategories().clear();

// Lưu lại để cập nhật bảng book_category
        bookService.saveBook(book1);
        bookService.deleteBook(book1.getId());
        return "redirect:/admin/book";
    }



}
