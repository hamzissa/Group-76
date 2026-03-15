package com.example.group76.repository;

import com.example.group76.model.CourseCompletion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CourseCompletionRepository extends JpaRepository<CourseCompletion, Long> {

    List<CourseCompletion> findByUserEmailOrderByCompletedAtDesc(String userEmail);

    Optional<CourseCompletion> findByUserEmailAndCourseName(String userEmail, String courseName);

    List<CourseCompletion> findByRatingIsNotNullOrderByCompletedAtDesc();

    List<CourseCompletion> findByCourseNameAndRatingIsNotNull(String courseName);
}