package com.example.bookshop.controller.client;

import com.example.bookshop.domain.Book;
import com.example.bookshop.domain.DTO.BookSearchDTO;
import com.example.bookshop.repository.BookRepository;
import com.example.bookshop.service.specification.BookSpec;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/books")
public class BookSearchController {

    @Autowired
    private BookRepository bookRepository;

    @GetMapping("/search")
    public ResponseEntity<List<BookSearchDTO>> searchBooks(@RequestParam String name) {
        // Use the specification to search for books by name
        List<Book> books = bookRepository.findAll(BookSpec.nameLike(name));

        // Convert Book entities to DTOs for the response
        List<BookSearchDTO> result = books.stream()
                .map(this::convertToDTO)
                .limit(10) // Limit results to improve performance
                .collect(Collectors.toList());

        return ResponseEntity.ok(result);
    }

    private BookSearchDTO convertToDTO(Book book) {
        BookSearchDTO dto = new BookSearchDTO();
        dto.setId(book.getId());
        dto.setName(book.getName());
        dto.setImage(book.getImage());

        return dto;
    }

}
