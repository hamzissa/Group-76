package com.example.group76.controller;

import com.example.group76.model.Badge;
import com.example.group76.model.User;
import com.example.group76.repository.BadgeRepository;
import com.example.group76.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.ArrayList;
import java.util.List;

@Controller
public class BadgeController {
	private final BadgeRepository badgeRepository;
	private final UserRepository userRepository;

	public BadgeController(BadgeRepository badgeRepository, UserRepository userRepository) {
		this.badgeRepository = badgeRepository;
		this.userRepository = userRepository;
	}

	@GetMapping("/badges")
	public String showBadges(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");

		if (user == null) {
			return "redirect:/login";
		}

		User currentUser = userRepository.findByEmail(user.getEmail());
		List<Badge> allBadges = badgeRepository.findAllByOrderByRequiredXpAsc();
		
		List<Badge> earnedBadges = new ArrayList<>();
		List<Badge> unearnedBadges = new ArrayList<>();

		for (Badge badge : allBadges) {
			if (currentUser.getXp() >= badge.getRequiredXp()) {
				earnedBadges.add(badge);
			} else {
				unearnedBadges.add(badge);
			}
		}

		model.addAttribute("user", currentUser);
		model.addAttribute("earnedBadges", earnedBadges);
		model.addAttribute("unearnedBadges", unearnedBadges);
		return "badges";
	}
}
