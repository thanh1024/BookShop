package com.example.bookshop.controller.client;

import com.example.bookshop.domain.Book;
import com.example.bookshop.domain.DTO.RegisterDTO;
import com.example.bookshop.domain.Order;
import com.example.bookshop.domain.User;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.OrderService;
import com.example.bookshop.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class HomePageController {
    @Autowired
    private BookService bookService;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private PasswordEncoder passwordEncoder;
    @GetMapping("/")
    public String homePage(Model model) {
        List<Book> allBooks = bookService.getAllBooks();
        List<Book> top10Books = allBooks.stream().limit(10).collect(Collectors.toList());
        model.addAttribute("books", top10Books);
        return "client/homepage/show";
    }


    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }
    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser")
                                 @Valid RegisterDTO registerDTO,
                                 BindingResult bindingResult
    ) {

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        User user = this.userService.registerDTOtoUser(registerDTO);
        String hashPassword = this.passwordEncoder.encode(user.getPassword());

        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("USER"));
        this.userService.handleSaveUser(user);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {

        return "client/auth/login";
    }

    @GetMapping("/access-deny")
    public String getDenyPage(Model model) {

        return "client/auth/deny";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = new User();

        long id =(long) session.getAttribute("id");
        user.setId(id);
        //Cart cart = this.productService.getCartByUser(user);
        List<Order> orders = this.orderService.findOrdersByUser(user);

        model.addAttribute("orders", orders);
        return "client/cart/order-history";
    }


}
