package com.example.group76.repository;

import com.example.group76.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByEmail(String email);

    // leaderboard query
    List<User> findTop10ByOrderByXpDesc();

}