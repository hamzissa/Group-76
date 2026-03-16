package com.example.group76.controller;

import com.example.group76.model.Badge;
import com.example.group76.model.Course;
import com.example.group76.model.CourseCompletion;
import com.example.group76.model.Goal;
import com.example.group76.model.User;
import com.example.group76.repository.BadgeRepository;
import com.example.group76.repository.CourseCompletionRepository;
import com.example.group76.repository.GoalTrackerRepository;
import com.example.group76.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    private final UserRepository userRepository;
    private final BadgeRepository badgeRepository;
    private final CourseCompletionRepository completionRepository;
    private final GoalTrackerRepository goalRepository;

    public DashboardController(UserRepository userRepository,
                               BadgeRepository badgeRepository,
                               CourseCompletionRepository completionRepository,
                               GoalTrackerRepository goalRepository) {
        this.userRepository = userRepository;
        this.badgeRepository = badgeRepository;
        this.completionRepository = completionRepository;
        this.goalRepository = goalRepository;
    }

    @GetMapping("/dashboard")
    public String showMenu(HttpSession session, Model m){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        User currentUser = userRepository.findByEmail(user.getEmail());
        m.addAttribute("user", currentUser);

        List<Badge> allBadges = badgeRepository.findAllByOrderByRequiredXpAsc();
        List<Badge> earnedBadges = allBadges.stream()
                .filter(b -> currentUser.getXp() >= b.getRequiredXp())
                .collect(Collectors.toList());
        List<Badge> unearnedBadges = allBadges.stream()
                .filter(b -> currentUser.getXp() < b.getRequiredXp())
                .collect(Collectors.toList());

        m.addAttribute("earnedBadges", earnedBadges);
        m.addAttribute("unearnedBadges", unearnedBadges);

        Course course1 = new Course("Artificial Intelligence",
                "https://academic.ibm.com/a2mt/downloads/artificial_intelligence#/");
        Course course2 = new Course("Data Science",
                "https://academic.ibm.com/a2mt/downloads/data_science#/");
        Course course3 = new Course("Security",
                "https://academic.ibm.com/a2mt/downloads/ibm_security#/");
        Course course4 = new Course("Quantum Computing",
                "https://academic.ibm.com/a2mt/downloads/quantum_computing#/");

        List<Course> courses = new ArrayList<>();
        courses.add(course1);
        courses.add(course2);
        courses.add(course3);
        courses.add(course4);

        m.addAttribute("courses", courses);

        List<CourseCompletion> recentReviews = completionRepository.findByRatingIsNotNullOrderByCompletedAtDesc()
                .stream()
                .limit(3)
                .collect(Collectors.toList());

        m.addAttribute("recentReviews", recentReviews);

        Goal activeGoal = goalRepository.findByUserIdAndActive(user.getId(), true);
        if (activeGoal != null) {
            if (activeGoal.getCreatedAt() != null && activeGoal.getDeadline() != null) {
                long completedForGoal =
                        completionRepository.countByUserEmailAndCompletedAtGreaterThanEqualAndCompletedAtLessThanEqual(
                                user.getEmail(),
                                activeGoal.getCreatedAt(),
                                activeGoal.getDeadline()
                        );
                activeGoal.setCompletedCount((int) completedForGoal);
            }

            boolean dashboardDeadlinePassed = activeGoal.getDeadline() != null
                    && LocalDateTime.now().isAfter(activeGoal.getDeadline());

            m.addAttribute("activeGoal", activeGoal);
            m.addAttribute("dashboardDeadlinePassed", dashboardDeadlinePassed);
        }

        return "dashboard";
    }
}