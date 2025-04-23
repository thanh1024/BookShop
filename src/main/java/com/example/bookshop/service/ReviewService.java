package com.example.bookshop.service;

import com.example.bookshop.domain.Review;
import com.example.bookshop.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    @Autowired
    private ReviewRepository reviewRepository;
    public Review saveReview(Review review) {
        return reviewRepository.save(review);
    }

    public List<Review> findByBookId(long bookId) {
        return reviewRepository.findByBookId(bookId);
    }
}
