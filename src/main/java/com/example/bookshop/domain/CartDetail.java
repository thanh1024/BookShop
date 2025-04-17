package com.example.bookshop.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


@Entity
@Table(name = "cart_detail")
@Getter
@Setter
public class CartDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private long quantity;

    private double price;

    // cart_id: long
    @ManyToOne
    @JoinColumn(name = "cart_id")
    private Cart cart;

    // product_id: long
    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;

    public Book getBook() {
        return book;
    }

    public void setProduct(Book book) {
        this.book = book;
    }

}