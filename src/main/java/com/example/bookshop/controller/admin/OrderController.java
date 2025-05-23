package com.example.bookshop.controller.admin;

import com.example.bookshop.domain.Order;
import com.example.bookshop.domain.OrderDetail;
import com.example.bookshop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/admin/order")
    public String getOrderTable(Model model, @RequestParam("page") Optional<String> optionalPage) {
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
        Page<Order> orders = this.orderService.getAllOrders(pageable);
        List<Order> listOrder = orders.getContent();

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orders.getTotalPages());

        model.addAttribute("orders", listOrder);
        return "admin/order/show";

    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Order order = this.orderService.getOrderById(id).get();
        List<OrderDetail> arrOrderDetails = order.getOrderDetails();
        model.addAttribute("orderDetails", arrOrderDetails);
        return "admin/order/detail";
    }
    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable Long id) {
        Order order = this.orderService.getOrderById(id).get();
        model.addAttribute("updateOrder", order);
        return "admin/order/update";
    }
    @PostMapping("/admin/order/update")
    public String updateOrder(@ModelAttribute("updateOrder") Order order) {

        this.orderService.handleUpdateOrder(order);
        return "redirect:/admin/order";
    }
    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable Long id) {
        Order order = this.orderService.getOrderById(id).get();
        model.addAttribute("id", id);
        model.addAttribute("deleteOrder", order);
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String deleteOrder(Model model, @ModelAttribute("deleteOrder") Order order) {
        this.orderService.handleDeleteOrder(order);

        return "redirect:/admin/order";
    }
}
