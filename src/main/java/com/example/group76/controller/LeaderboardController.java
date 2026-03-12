package com.example.group76.controller;

import com.example.group76.model.User;
import com.example.group76.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class LeaderboardController {

    private final UserRepository userRepository;

    public LeaderboardController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/leaderboard")
    public String showLeaderboard(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        List<User> leaderboard = userRepository.findTop10ByOrderByXpDesc();

        model.addAttribute("leaderboard", leaderboard);

        return "leaderboard";
    }
}
