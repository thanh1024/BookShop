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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping("admin/book/category")
    public String getCategoryPage(){
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
}
