package com.example.bookshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashBoardController {
    @GetMapping("/admin")
    public String getDashboardPage(Model model){
//        model.addAttribute("countProducts", this.userService.countProducts());
//        model.addAttribute("countUsers", this.userService.countUsers());
//        model.addAttribute("countOrders", this.userService.countOrders());
        return "admin/dashboard/show";
    }
}
