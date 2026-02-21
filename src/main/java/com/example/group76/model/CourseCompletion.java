package com.example.group76.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "course_completions")
public class CourseCompletion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // We don’t have a real User table wired properly yet,
    // so store the logged-in user identifier from session.
    @Column(nullable = false)
    private String userEmail;

    @Column(nullable = false)
    private String courseName;

    @Column(nullable = false)
    private LocalDateTime completedAt;

    public CourseCompletion() {}

    public CourseCompletion(String userEmail, String courseName, LocalDateTime completedAt) {
        this.userEmail = userEmail;
        this.courseName = courseName;
        this.completedAt = completedAt;
    }

    public Long getId() { return id; }
    public String getUserEmail() { return userEmail; }
    public String getCourseName() { return courseName; }
    public LocalDateTime getCompletedAt() { return completedAt; }

    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }
}