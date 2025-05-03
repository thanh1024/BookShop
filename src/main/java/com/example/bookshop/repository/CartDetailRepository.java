package com.example.bookshop.repository;

import com.example.bookshop.domain.Book;
import com.example.bookshop.domain.Cart;
import com.example.bookshop.domain.CartDetail;
import com.example.bookshop.domain.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndBook(Cart cart, Book book);

    CartDetail findByCartAndBook(Cart cart, Book book);
}
