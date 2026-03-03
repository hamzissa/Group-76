package com.example.group76.config;

import com.example.group76.model.Badge;
import com.example.group76.repository.BadgeRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class BadgeDataLoader implements CommandLineRunner {
private final BadgeRepository badgeRepository;

public BadgeDataLoader(BadgeRepository badgeRepository) {
this.badgeRepository = badgeRepository;
}

@Override
public void run(String... args) throws Exception {
if (badgeRepository.count() == 0) {
badgeRepository.save(new Badge("Starter", "Complete your first course", 0, "🎯", "/images/badges/starter.svg"));
badgeRepository.save(new Badge("Bronze", "Earn 100 XP", 100, "🥉", "/images/badges/bronze.svg"));
badgeRepository.save(new Badge("Silver", "Earn 500 XP", 500, "🥈", "/images/badges/silver.svg"));
badgeRepository.save(new Badge("Gold", "Earn 1000 XP", 1000, "🥇", "/images/badges/gold.svg"));
badgeRepository.save(new Badge("Platinum", "Earn 2000 XP", 2000, "💎", "/images/badges/platinum.svg"));
badgeRepository.save(new Badge("Legend", "Earn 5000 XP", 5000, "👑", "/images/badges/legend.svg"));
}
}
}
