package com.example.group76.controller;

import com.example.group76.model.CourseCompletion;
import com.example.group76.model.CourseProgress;
import com.example.group76.model.User;
import com.example.group76.repository.CourseCompletionRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
public class CourseProgressController {

    private final CourseCompletionRepository completionRepo;

    public CourseProgressController(CourseCompletionRepository completionRepo) {
        this.completionRepo = completionRepo;
    }

    private final CourseProgress progress =
            new CourseProgress("No Course Selected", 3600);

    @GetMapping("/course-progress")
    public String show(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("progress", progress);
        return "courseProgress";
    }

    @PostMapping("/course-progress/start")
    public String start(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        progress.start();
        return "redirect:/course-progress";
    }

    @PostMapping("/course-progress/pause")
    public String pause(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        progress.pause();
        return "redirect:/course-progress";
    }

    @PostMapping("/course-progress/resume")
    public String resume(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        progress.resume();
        return "redirect:/course-progress";
    }

    @PostMapping("/course-progress/complete")
    public String complete(HttpSession session) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        progress.complete();

        CourseCompletion cc = new CourseCompletion(
                user.getEmail(),
                progress.getCourseName(),
                LocalDateTime.now()
        );

        completionRepo.save(cc);

        return "redirect:/completion";
    }

    @GetMapping("/start-course")
    public String startAndRedirect(@RequestParam String url,
                                   @RequestParam String name,
                                   HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        progress.resetWithNewCourse(name);
        progress.start();

        return "redirect:" + url;
    }
}