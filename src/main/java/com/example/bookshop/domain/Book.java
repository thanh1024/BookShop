package com.example.bookshop.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "Books")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class Book implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotBlank(message = "Tên sách không được để trống")
    private String name;

    @NotNull(message = "Giá không được để trống")
    @DecimalMin(value = "0", message = "Giá phải lớn hơn 0")
    private Double price; // ✅ dùng Double thay vì double

    @NotBlank(message = "Mô tả chi tiết không được để trống")
    private String detailDesc;

    @NotBlank(message = "Mô tả ngắn không được để trống")
    private String shortDesc;

    @NotNull(message = "Số lượng không được để trống")
    @Min(value = 0, message = "Số lượng phải ≥ 0")
    private Long quantity; // ✅ dùng Long thay vì long

    @NotBlank(message = "Nhà xuất bản không được để trống")
    private String publisher;

    @NotBlank(message = "Tác giả không được để trống")
    private String author;

    private String image;

    private Long sold;

    @ManyToMany
    @JoinTable(
            name = "book_category",
            joinColumns = @JoinColumn(name = "book_id"),
            inverseJoinColumns = @JoinColumn(name = "category_id")
    )
    @NotNull
    private Set<Category> categories = new HashSet<>();

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public @NotBlank(message = "Tên sách không được để trống") String getName() {
        return name;
    }

    public @NotBlank(message = "Mô tả chi tiết không được để trống") String getDetailDesc() {
        return detailDesc;
    }

    public @NotNull(message = "Số lượng không được để trống") @Min(value = 0, message = "Số lượng phải ≥ 0") Long getQuantity() {
        return quantity;
    }

    public @NotNull Set<Category> getCategories() {
        return categories;
    }

    public void setCategories(@NotNull Set<Category> categories) {
        this.categories = categories;
    }

    public Long getSold() {
        return sold;
    }

    public void setSold(Long sold) {
        this.sold = sold;
    }

    public String getImage() {
        return image;
    }

    public void setImage( String image) {
        this.image = image;
    }

    public @NotBlank(message = "Tác giả không được để trống") String getAuthor() {
        return author;
    }

    public void setAuthor(@NotBlank(message = "Tác giả không được để trống") String author) {
        this.author = author;
    }

    public @NotBlank(message = "Nhà xuất bản không được để trống") String getPublisher() {
        return publisher;
    }

    public void setPublisher(@NotBlank(message = "Nhà xuất bản không được để trống") String publisher) {
        this.publisher = publisher;
    }

    public void setQuantity(@NotNull(message = "Số lượng không được để trống") @Min(value = 0, message = "Số lượng phải ≥ 0") Long quantity) {
        this.quantity = quantity;
    }

    public @NotBlank(message = "Mô tả ngắn không được để trống") String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(@NotBlank(message = "Mô tả ngắn không được để trống") String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public void setDetailDesc(@NotBlank(message = "Mô tả chi tiết không được để trống") String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public void setName(@NotBlank(message = "Tên sách không được để trống") String name) {
        this.name = name;
    }

    public @NotNull(message = "Giá không được để trống") @DecimalMin(value = "0", message = "Giá phải lớn hơn 0") Double getPrice() {
        return price;
    }

    public void setPrice(@NotNull(message = "Giá không được để trống") @DecimalMin(value = "0", message = "Giá phải lớn hơn 0") Double price) {
        this.price = price;
    }
}

