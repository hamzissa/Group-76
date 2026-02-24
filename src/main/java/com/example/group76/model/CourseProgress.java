package com.example.group76.model;

import java.time.Duration;
import java.time.LocalDateTime;

public class CourseProgress {

    private String courseName;
    private String status;

    private LocalDateTime startedAt;
    private LocalDateTime lastResumedAt;
    private LocalDateTime completedAt;

    private long totalSecondsSpent;
    private long estimatedTotalSeconds;

    public CourseProgress(String courseName, long estimatedTotalSeconds) {
        this.courseName = courseName;
        this.status = "NOT_STARTED";
        this.totalSecondsSpent = 0;
        this.estimatedTotalSeconds = Math.max(estimatedTotalSeconds, 1);
    }

    public void resetWithNewCourse(String newCourseName) {
        this.courseName = newCourseName;
        this.status = "NOT_STARTED";
        this.totalSecondsSpent = 0;
        this.startedAt = null;
        this.lastResumedAt = null;
        this.completedAt = null;
    }

    public void start() {
        if ("NOT_STARTED".equals(status)) {
            startedAt = LocalDateTime.now();
            lastResumedAt = LocalDateTime.now();
            status = "IN_PROGRESS";
        }
    }

    public void pause() {
        if ("IN_PROGRESS".equals(status)) {
            totalSecondsSpent += secondsSinceLastResume();
            status = "PAUSED";
        }
    }

    public void resume() {
        if ("PAUSED".equals(status)) {
            lastResumedAt = LocalDateTime.now();
            status = "IN_PROGRESS";
        }
    }

    public void complete() {
        if ("COMPLETED".equals(status)) return;

        if ("IN_PROGRESS".equals(status)) {
            totalSecondsSpent += secondsSinceLastResume();
        }

        completedAt = LocalDateTime.now();
        status = "COMPLETED";
    }

    private long secondsSinceLastResume() {
        if (lastResumedAt == null) return 0;
        long seconds = Duration.between(lastResumedAt, LocalDateTime.now()).getSeconds();
        lastResumedAt = LocalDateTime.now();
        return Math.max(seconds, 0);
    }

    public long getLiveTotalSecondsSpent() {
        if ("IN_PROGRESS".equals(status) && lastResumedAt != null) {
            long seconds = Duration.between(lastResumedAt, LocalDateTime.now()).getSeconds();
            return totalSecondsSpent + Math.max(seconds, 0);
        }
        return totalSecondsSpent;
    }

    public int getProgressPercent() {
        long seconds = getLiveTotalSecondsSpent();
        double ratio = (double) seconds / (double) estimatedTotalSeconds;
        int percent = (int) Math.round(ratio * 100.0);
        return Math.max(0, Math.min(100, percent));
    }

    public String getCourseName() { return courseName; }
    public String getStatus() { return status; }
    public LocalDateTime getStartedAt() { return startedAt; }
    public LocalDateTime getCompletedAt() { return completedAt; }
    public long getEstimatedTotalSeconds() { return estimatedTotalSeconds; }
}