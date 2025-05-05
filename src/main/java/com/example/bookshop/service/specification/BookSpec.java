package com.example.bookshop.service.specification;

import com.example.bookshop.domain.Book;
import com.example.bookshop.domain.Book_;
import com.example.bookshop.domain.Category;
import jakarta.persistence.criteria.Join;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public class BookSpec {
    public static Specification<Book> nameLike(String name) {
        return (root, query, criteriaBuilder)
                -> criteriaBuilder.like(root.get(Book_.NAME), "%" + name + "%");
    }
    public static Specification<Book> searchBooks(String name) {
        return Specification.where(nameLike(name));
    }

    public static Specification<Book> hasCategories(List<Long> categoryIds) {
        return (root, query, criteriaBuilder) -> {
            if (categoryIds == null || categoryIds.isEmpty()) {
                return criteriaBuilder.conjunction();
            }

            Join<Book, Category> categoryJoin = root.join("categories");
            return categoryJoin.get("id").in(categoryIds);
        };
    }

}
