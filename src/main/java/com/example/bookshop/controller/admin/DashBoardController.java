package com.example.bookshop.controller.admin;

import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashBoardController {
    @Autowired
    private UserService userService;
    @GetMapping("/admin")
    public String getDashboardPage(Model model){
        model.addAttribute("countBooks", this.userService.countBooks());
        model.addAttribute("countUsers", this.userService.countUsers());
        model.addAttribute("countOrders", this.userService.countOrders());
        return "admin/dashboard/show";
    }
}
