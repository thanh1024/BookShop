package com.example.bookshop.controller.admin;

import com.example.bookshop.domain.Category;
import com.example.bookshop.domain.User;
import com.example.bookshop.service.CategoryService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping("admin/book/category")
    public String getCategoryPage(Model model){
        model.addAttribute("categories", categoryService.findAll());
        return "admin/book/category";
    }

    @GetMapping("/admin/book/createCategory")
    public String getCategoryCreate(Model model) {
        model.addAttribute("newCategory", new Category());
        return "admin/book/createCategory";
    }

    @PostMapping("/admin/book/createCategory")
    public String createCategoryPage  (Model model,
                                 @ModelAttribute("newCategory") @Valid Category category,
                                 BindingResult newCategoryBindingResult) {

        List<FieldError> errors = newCategoryBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>> " + error.getField() + " - " + error.getDefaultMessage());
        }

        if (newCategoryBindingResult.hasErrors()) {
            return "admin/book/createCategory";
        }
        // Save
        this.categoryService.save(category);
        return "redirect:/admin/book/category";
    }
    @GetMapping("admin/book/category/{id}")
    public String categoryDetail(@PathVariable("id") Long id, Model model) {
        Category category = categoryService.getCategoryById(id);
        if (category == null) {
            return "redirect:/admin/book/category";
        }
        model.addAttribute("category", category);
        return "admin/book/categoryDetail";
    }

    @GetMapping("admin/book/updateCategory/{id}")
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        Category category = categoryService.getCategoryById(id);
        model.addAttribute("categoryUpdate", category);
        return "admin/book/updateCategory";
    }

    @PostMapping("admin/book/updateCategory")
    public String updateCategory(@Valid @ModelAttribute("categoryUpdate") Category category,
                                 BindingResult result) {
        if (result.hasErrors()) {
            return "admin/book/updateCategory";
        }

        Category category1 = categoryService.getCategoryById(category.getId());
        if (category1 != null) {
            category1.setName(category.getName());
            category1.setDescription(category.getDescription());
            this.categoryService.save(category1);
        }
        return "redirect:/admin/book/category";
    }

    @GetMapping("admin/book/deleteCategory/{id}")
    public String showDeleteCategoryPage(@PathVariable("id") Long id, Model model) {
        Category category = categoryService.getCategoryById(id);
        if (category == null) {
            return "redirect:/admin/book/category";
        }
        model.addAttribute("id", id);
        model.addAttribute("categoryDelete", category);
        return "admin/book/deleteCategory";
    }

    @PostMapping("admin/book/deleteCategory")
    public String deleteCategory(@ModelAttribute("categoryDelete") Category category) {
        categoryService.deleteCategoryById(category.getId());
        return "redirect:/admin/book/category";
    }


}
