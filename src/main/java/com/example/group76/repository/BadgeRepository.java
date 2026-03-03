package com.example.group76.repository;

import com.example.group76.model.Badge;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface BadgeRepository extends JpaRepository<Badge, Long> {
	List<Badge> findAllByOrderByRequiredXpAsc();
}
