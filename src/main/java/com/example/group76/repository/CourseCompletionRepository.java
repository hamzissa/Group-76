package com.example.group76.repository;

import com.example.group76.model.CourseCompletion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CourseCompletionRepository extends JpaRepository<CourseCompletion, Long> {
    List<CourseCompletion> findByUserEmailOrderByCompletedAtDesc(String userEmail);
}