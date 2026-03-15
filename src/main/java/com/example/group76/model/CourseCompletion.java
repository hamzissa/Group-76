package com.example.group76.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "course_completions")
public class CourseCompletion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String userEmail;

    @Column(nullable = false)
    private String courseName;

    @Column(nullable = false)
    private LocalDateTime completedAt;

    @Column
    private Integer rating;

    @Column(length = 1000)
    private String comment;

    public CourseCompletion() {}

    public CourseCompletion(String userEmail, String courseName, LocalDateTime completedAt) {
        this.userEmail = userEmail;
        this.courseName = courseName;
        this.completedAt = completedAt;
    }

    public Long getId() {
        return id;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public String getCourseName() {
        return courseName;
    }

    public LocalDateTime getCompletedAt() {
        return completedAt;
    }

    public Integer getRating() {
        return rating;
    }

    public String getComment() {
        return comment;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public void setCompletedAt(LocalDateTime completedAt) {
        this.completedAt = completedAt;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getFormattedCompletedAt() {
        if (completedAt == null) {
            return "";
        }
        return completedAt.format(DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm"));
    }

    public String getStars() {
        if (rating == null || rating < 1) {
            return "";
        }
        return "⭐".repeat(rating);
    }
}