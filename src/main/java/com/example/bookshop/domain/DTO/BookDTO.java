package com.example.bookshop.domain.DTO;

public class BookDTO {
    private long id;
    private String title;
    private String coverImage; // URL hoặc tên file ảnh

    public BookDTO() {
    }

    public BookDTO(long id, String title, String coverImage) {
        this.id = id;
        this.title = title;
        this.coverImage = coverImage;
    }

    // Getters & Setters
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }
}
