package com.example.bookshop.controller.client;

import com.example.bookshop.domain.*;
import com.example.bookshop.repository.BookRepository;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.CategoryService;
import com.example.bookshop.service.ReviewService;
import com.example.bookshop.service.specification.BookSpec;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class ItemController {
    @Autowired
    private BookService bookService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private BookRepository bookRepository;

    @GetMapping("book/{bookId}")
    public String showBookDetail(@PathVariable("bookId") long bookId, Model model) {
        Book book = bookService.getBookById(bookId);
        if (book == null) {
            return "redirect:/";
        }

        List<Review> reviews = reviewService.findByBookId(bookId);
        model.addAttribute("book", book);
        model.addAttribute("reviews", reviews);

        return "client/book/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request){
        HttpSession session = request.getSession(false);
        String email =(String) session.getAttribute("email");
        long productId = id;

        this.bookService.handleAddProductToCart(email, productId, session, 1);
        return "redirect:/";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            HttpServletRequest request,
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.bookService.handleAddProductToCart(email, id, session, quantity);
        return "redirect:/book/" + id;
    }

    @GetMapping("/cart")
    public String getCartTable(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = new User();

        long id =(long) session.getAttribute("id");
        user.setId(id);
        Cart cart = this.bookService.getCartByUser(user);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() :cart.getCartDetails();
        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice()*cd.getQuantity();
        }
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);
        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable Long id, HttpServletRequest request){
        HttpSession session = request.getSession(false);
        long cartDetailId = id;
        this.bookService.deleteACartDetail(cartDetailId, session);
        return "redirect:/cart";
    }


    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.bookService.getCartByUser(currentUser);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/checkout";
    }


    @PostMapping("/confirm-checkout")
    public String getCheckoutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>(null) : cart.getCartDetails();
        this.bookService.handleUpdateCartBeforeCheckout(cartDetails);

        return "redirect:/checkout";
    }
    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");
        this.bookService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone);
        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThanksPage(Model model) {
        return "client/cart/thanks";
    }

    @GetMapping("/books")
    public String getBooksPage(
            Model model,
            @RequestParam(value = "category", required = false) List<Long> categoryIds,
            @RequestParam("page") Optional<String> optionalPage,
            HttpServletRequest request
    ) {
        List<Category> categories = this.categoryService.findAll();

        // Parse page parameter
        int page = 1;
        try {
            if (optionalPage.isPresent()) {
                page = Integer.parseInt(optionalPage.get());
            }
        } catch (Exception e) {
            // Default to page 1 on error
        }

        // Create pageable with 2 items per page
        Pageable pageable = PageRequest.of(page - 1, 2);

        // Build specification based on filters
        Specification<Book> spec = Specification.where(null);
        if (categoryIds != null && !categoryIds.isEmpty()) {
            spec = spec.and(BookSpec.hasCategories(categoryIds));
        }

        // Fetch books with specification
        Page<Book> book = bookRepository.findAll(spec, pageable);
        List<Book> books = book.getContent();

        // Build query string for pagination links
        StringBuilder queryBuilder = new StringBuilder();
        if (categoryIds != null && !categoryIds.isEmpty()) {
            for (Long categoryId : categoryIds) {
                queryBuilder.append("&category=").append(categoryId);
            }
        }
        String queryString = queryBuilder.toString();

        // Add attributes to the model
        model.addAttribute("categories", categories);
        model.addAttribute("books", books);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", book.getTotalPages());
        model.addAttribute("queryString", queryString);

        return "client/book/show";
    }

}
