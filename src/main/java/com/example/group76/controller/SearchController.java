package com.example.group76.controller;

import com.example.group76.model.Course;
import com.example.group76.model.CourseFilter;
import com.example.group76.service.CourseSearchService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/search")
public class SearchController {

    private final CourseSearchService courseSearchService;

    public SearchController() {
        this.courseSearchService = new CourseSearchService();
    }

    private List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        courses.add(new Course("Artificial Intelligence",
                "https://academic.ibm.com/a2mt/downloads/artificial_intelligence#/"));
        courses.add(new Course("Data Science",
                "https://academic.ibm.com/a2mt/downloads/data_science#/"));
        courses.add(new Course("Security",
                "https://academic.ibm.com/a2mt/downloads/ibm_security#/"));
        courses.add(new Course("Quantum Computing",
                "https://academic.ibm.com/a2mt/downloads/quantum_computing#/"));
        return courses;
    }

    @GetMapping
    public String showSearchPage(HttpSession session, Model model){
        if (session.getAttribute("user") == null) return "redirect:/login";

        CourseFilter filter = new CourseFilter();
        List<Course> courses = getAllCourses();

        model.addAttribute("filter", filter);
        model.addAttribute("searchResults", courses);
        return "searchResults";
    }

    @PostMapping
    public String searchCourses(@ModelAttribute CourseFilter filter, HttpSession session, Model model){
        if (session.getAttribute("user") == null) return "redirect:/login";

        List<Course> filtered = courseSearchService.searchCourses(getAllCourses(), filter);

        model.addAttribute("filter", filter);
        model.addAttribute("searchResults", filtered);
        return "searchResults";
    }
}