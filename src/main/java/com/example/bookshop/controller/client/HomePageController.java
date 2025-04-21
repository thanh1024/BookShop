package com.example.bookshop.controller.client;

import com.example.bookshop.domain.DTO.RegisterDTO;
import com.example.bookshop.domain.User;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class HomePageController {
    @Autowired
    private BookService bookService;

    @Autowired
    private UserService userService;
    @GetMapping("/")
    public String homePage(Model model) {
        model.addAttribute("books", bookService.getAllBooks());
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


}
