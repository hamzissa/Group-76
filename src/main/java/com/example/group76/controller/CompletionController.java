package com.example.group76.controller;

import com.example.group76.model.CourseCompletion;
import com.example.group76.model.User;
import com.example.group76.repository.CourseCompletionRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Controller
public class CompletionController {

    private final CourseCompletionRepository completionRepo;

    public CompletionController(CourseCompletionRepository completionRepo) {
        this.completionRepo = completionRepo;
    }

    // View completion history
    @GetMapping("/completion")
    public String completionPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        List<CourseCompletion> completions =
                completionRepo.findByUserEmailOrderByCompletedAtDesc(user.getEmail());

        model.addAttribute("completions", completions);
        return "completion";
    }

    // Mark a course as completed (simulate IBM integration)
    @PostMapping("/completion/mark")
    public String markCompleted(@RequestParam("courseName") String courseName,
                                HttpSession session) {

        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        CourseCompletion cc = new CourseCompletion(
                user.getEmail(),
                courseName,
                LocalDateTime.now()
        );

        completionRepo.save(cc);

        // After recording, go back to history page
        return "redirect:/completion";
    }
}
