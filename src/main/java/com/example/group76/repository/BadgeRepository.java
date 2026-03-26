package com.example.group76.repository;

import com.example.group76.model.Badge;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

// Repository = handles database operations for badges
public interface BadgeRepository extends JpaRepository<Badge, Long> {
	// Used to display badges in order from lowest XP to highest XP
	List<Badge> findAllByOrderByRequiredXpAsc();
}
