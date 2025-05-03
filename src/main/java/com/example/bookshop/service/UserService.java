package com.example.bookshop.service;

import com.example.bookshop.domain.DTO.RegisterDTO;
import com.example.bookshop.domain.Role;
import com.example.bookshop.domain.User;
import com.example.bookshop.repository.BookRepository;
import com.example.bookshop.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.bookshop.repository.RoleRepository;
import com.example.bookshop.repository.UserRepository;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private OrderRepository orderRepository;


    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public List<User> getAllUsersByEmail(String email) {
        return this.userRepository.findOneByEmail(email);
    }

    public User handleSaveUser(User user) {
        User user1 = this.userRepository.save(user);
        System.out.println(user1);
        return user1;
    }

    public User getUserById(long id) {
        return this.userRepository.findById(id);
    }

    public void deleteAUser(long id) {
        this.userRepository.deleteById(id);
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        return user;
    }

    public User getUSerByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    public long countBooks(){
        return this.bookRepository.count();
    }
    public long countUsers(){
        return this.userRepository.count();
    }
    public long countOrders(){
        return this.orderRepository.count();
    }
}
