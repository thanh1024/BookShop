package com.example.bookshop.repository;

import java.util.List;

import com.example.bookshop.domain.Order;
import com.example.bookshop.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>{
    List<Order> findByUser(User user);
    Page<Order> findAll(Pageable page);


}
