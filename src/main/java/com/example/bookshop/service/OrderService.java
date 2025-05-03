package com.example.bookshop.service;

import com.example.bookshop.domain.Order;
import com.example.bookshop.domain.OrderDetail;
import com.example.bookshop.domain.User;
import com.example.bookshop.repository.OrderDetailRepository;
import com.example.bookshop.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public Page<Order> getAllOrders(Pageable page) {
        return this.orderRepository.findAll(page);
    }
    public Optional<Order> getOrderById(long id){
        return this.orderRepository.findById(id);
    }
    public void handleUpdateOrder(Order order){
        Order upOrder = this.orderRepository.findById(order.getId()).get();
        upOrder.setStatus(order.getStatus());
        this.orderRepository.save(upOrder);
    }
    public void handleDeleteOrder(Order order){
        Order delOrder = this.orderRepository.findById(order.getId()).get();
        // delete order_detail
        List<OrderDetail> orderDetails = delOrder.getOrderDetails();
        for (OrderDetail cd : orderDetails) {
            this.orderDetailRepository.deleteById(cd.getId());;
        }
        this.orderRepository.deleteById(order.getId());

    }
    public List<Order> findOrdersByUser(User user) {
        return this.orderRepository.findByUser(user);
    }

}
