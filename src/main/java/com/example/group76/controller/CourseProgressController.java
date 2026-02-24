package com.example.group76.controller;

import com.example.group76.model.CourseCompletion;
import com.example.group76.model.CourseProgress;
import com.example.group76.model.User;
import com.example.group76.repository.CourseCompletionRepository;
import com.example.group76.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
public class CourseProgressController {

    private final CourseCompletionRepository completionRepo;
    private final UserRepository userRepository;

    public CourseProgressController(CourseCompletionRepository completionRepo, UserRepository userRepository) {
        this.completionRepo = completionRepo;
        this.userRepository = userRepository;
    }

    private final CourseProgress progress =
            new CourseProgress("No Course Selected", 3600);

    @GetMapping("/course-progress")
    public String show(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        User currentUser = userRepository.findByEmail(user.getEmail());
        model.addAttribute("progress", progress);
        model.addAttribute("user", currentUser);
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
        User userInSession = (User) session.getAttribute("user");

        if (userInSession == null) {
            return "redirect:/login";
        }

        progress.complete();

        CourseCompletion cc = new CourseCompletion(
                userInSession.getEmail(),
                progress.getCourseName(),
                LocalDateTime.now()
        );
        completionRepo.save(cc);

        User user = userRepository.findByEmail(userInSession.getEmail());
        if (user != null) {
            user.setXp(user.getXp() + 100);
            userRepository.save(user);
            session.setAttribute("user", user);
        }

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