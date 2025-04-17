package com.example.bookshop.domain;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "Books")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class Book implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String name;
    private double price;
    private String image;
    private String detailDesc;
    private String shortDesc;
    private long quantity;
    private long sold;
    private String publisher;

    @ManyToMany
    @JoinTable(
            name = "book_category",
            joinColumns = @JoinColumn(name = "book_id"),
            inverseJoinColumns = @JoinColumn(name = "category_id")
    )
    private Set<Category> categories = new HashSet<>();
}

