package com.example.bookshop.controller.client;

import com.example.bookshop.domain.Book;
import com.example.bookshop.domain.Review;
import com.example.bookshop.domain.User;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ReviewController {
    @Autowired
    private ReviewService reviewService;

    @Autowired
    private BookService bookService;

    @PostMapping("/book/{bookId}/review")
    public String addReview(@PathVariable("bookId") long bookId, @RequestParam("rating") int rating,
                            @RequestParam("comment") String comment, HttpSession session) {
        Book book = bookService.getBookById(bookId);
        if (book == null) {
            return "redirect:/";
        }

        Review review = new Review();
        review.setBook(book);
        review.setRating(rating);
        review.setComment(comment);
        review.setUser((User) session.getAttribute("user"));
        reviewService.saveReview(review);

        return "redirect:/book/" + bookId;
    }


}
