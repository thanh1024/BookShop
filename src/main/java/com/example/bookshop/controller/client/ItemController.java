package com.example.bookshop.controller.client;

import com.example.bookshop.domain.Book;
import com.example.bookshop.domain.Review;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.CategoryService;
import com.example.bookshop.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class ItemController {
    @Autowired
    private BookService bookService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ReviewService reviewService;

    @GetMapping("book/{bookId}")
    public String showBookDetail(@PathVariable("bookId") long bookId, Model model) {
        // Lấy thông tin sách và danh sách đánh giá từ database
        Book book = bookService.getBookById(bookId);
        if (book == null) {
            return "redirect:/"; // Quay lại trang chủ nếu không tìm thấy sách
        }

        List<Review> reviews = reviewService.findByBookId(bookId);
        model.addAttribute("book", book);
        model.addAttribute("reviews", reviews);

        return "client/book/detail"; // Trả về JSP để hiển thị thông tin chi tiết sách
    }
}
