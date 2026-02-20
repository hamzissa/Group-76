package com.example.group76.controller;

import com.example.group76.model.CourseProgress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class CourseProgressController {

    private final CourseProgress progress =
            new CourseProgress("No Course Selected", 3600);

    @GetMapping("/course-progress")
    public String show(Model model) {
        model.addAttribute("progress", progress);
        return "courseProgress";
    }

    @PostMapping("/course-progress/start")
    public String start() {
        progress.start();
        return "redirect:/course-progress";
    }

    @PostMapping("/course-progress/pause")
    public String pause() {
        progress.pause();
        return "redirect:/course-progress";
    }

    @PostMapping("/course-progress/resume")
    public String resume() {
        progress.resume();
        return "redirect:/course-progress";
    }

    @PostMapping("/course-progress/complete")
    public String complete() {
        progress.complete();
        return "redirect:/course-progress";
    }

    @GetMapping("/start-course")
    public String startAndRedirect(@RequestParam String url,
                                   @RequestParam String name) {

        progress.resetWithNewCourse(name);
        progress.start();

        return "redirect:" + url;
    }
}