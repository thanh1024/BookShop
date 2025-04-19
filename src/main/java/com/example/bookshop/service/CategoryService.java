package com.example.bookshop.service;

import com.example.bookshop.domain.Category;
import com.example.bookshop.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    @Autowired
    private CategoryRepository categoryRepository;

    public List<Category> findAll() {
        return categoryRepository.findAll();
    }
    public Category getCategoryById(long id) {
        return categoryRepository.getById(id);
    }
    public Category save(Category category) {
        return categoryRepository.save(category);
    }
    public void deleteCategoryById(long id) {
        categoryRepository.deleteById(id);
    }

    public List<Category> findAllByIds(List<Long> ids) {
        return categoryRepository.findAllById(ids);
    }
}
