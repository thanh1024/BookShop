package com.example.bookshop.repository;

import com.example.bookshop.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

//crud: create, read, update, delete
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User user);

    void deleteById(long id);

    List<User> findOneByEmail(String email);

    List<User> findAll();

    User findById(long id); // null
}
