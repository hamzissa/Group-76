package com.example.group76.controller;

import com.example.group76.model.Course;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Controller
public class PopularCoursesController {

    @GetMapping("/popular-courses")
    public String showPopularCourses(Model model) {

        List<Course> allCourses = new ArrayList<>();

        // External IBM links for each course
        allCourses.add(new Course("Artificial Intelligence", "https://academic.ibm.com/a2mt/downloads/artificial_intelligence#/"));
        allCourses.add(new Course("Data Science", "https://academic.ibm.com/a2mt/downloads/data_science#/"));
        allCourses.add(new Course("Security", "https://academic.ibm.com/a2mt/downloads/ibm_security#/"));
        allCourses.add(new Course("Quantum Computing", "https://academic.ibm.com/a2mt/downloads/quantum_computing#/"));

        // Shuffle and take top 3
        Collections.shuffle(allCourses);
        List<Course> topCourses = allCourses.subList(0, 3);

        model.addAttribute("popularCourses", topCourses);

        return "popular-courses";
    }
}