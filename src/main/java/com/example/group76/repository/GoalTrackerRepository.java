package com.example.group76.repository;

import com.example.group76.model.Goal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GoalTrackerRepository extends JpaRepository<Goal, Long> {
    Goal findByUserIdAndActive(Long userId, boolean active);
}