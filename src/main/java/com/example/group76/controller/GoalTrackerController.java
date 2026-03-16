package com.example.group76.controller;

import com.example.group76.model.Goal;
import com.example.group76.model.User;
import com.example.group76.repository.CourseCompletionRepository;
import com.example.group76.repository.GoalTrackerRepository;
import com.example.group76.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;

@Controller
public class GoalTrackerController {

    private final GoalTrackerRepository goalRepository;
    private final UserRepository userRepository;
    private final CourseCompletionRepository courseCompletionRepository;

    public GoalTrackerController(GoalTrackerRepository goalRepository,
                                 UserRepository userRepository,
                                 CourseCompletionRepository courseCompletionRepository) {
        this.goalRepository = goalRepository;
        this.userRepository = userRepository;
        this.courseCompletionRepository = courseCompletionRepository;
    }

    @GetMapping("/goalTracker")
    public String showGoalTracker(@RequestParam(value = "success", required = false) String success,
                                  @RequestParam(value = "error", required = false) String error,
                                  HttpSession session,
                                  Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Goal activeGoal = goalRepository.findByUserIdAndActive(user.getId(), true);

        if (activeGoal == null) {
            activeGoal = new Goal();
            activeGoal.setUser(user);
            activeGoal.setTarget(1);
            activeGoal.setReward("+50 XP");
            activeGoal.setCompletedCount(0);
            activeGoal.setActive(true);
            activeGoal.setRewardClaimed(false);
            activeGoal.setCreatedAt(LocalDateTime.now());
            activeGoal.setDeadline(LocalDateTime.now().plusDays(1));
            goalRepository.save(activeGoal);
        }

        if (activeGoal.getCreatedAt() == null) {
            activeGoal.setCreatedAt(LocalDateTime.now());
        }

        if (activeGoal.getDeadline() == null) {
            activeGoal.setDeadline(activeGoal.getCreatedAt().plusDays(1));
        }

        long completedWithinGoalWindow =
                courseCompletionRepository.countByUserEmailAndCompletedAtGreaterThanEqualAndCompletedAtLessThanEqual(
                        user.getEmail(),
                        activeGoal.getCreatedAt(),
                        activeGoal.getDeadline()
                );

        activeGoal.setCompletedCount((int) completedWithinGoalWindow);

        LocalDateTime now = LocalDateTime.now();
        boolean deadlinePassed = now.isAfter(activeGoal.getDeadline());

        if (deadlinePassed && !activeGoal.isRewardClaimed() && activeGoal.getCompletedCount() < activeGoal.getTarget()) {
            activeGoal.setActive(false);
            goalRepository.save(activeGoal);
            model.addAttribute("expiredMessage", "Your goal has expired. Set a new goal to try again.");
        }

        if (!deadlinePassed
                && activeGoal.getCompletedCount() >= activeGoal.getTarget()
                && !activeGoal.isRewardClaimed()) {

            User currentUser = userRepository.findByEmail(user.getEmail());
            if (currentUser != null) {
                currentUser.setXp(currentUser.getXp() + 50);
                userRepository.save(currentUser);
                session.setAttribute("user", currentUser);
            }

            activeGoal.setRewardClaimed(true);
            goalRepository.save(activeGoal);
            model.addAttribute("achievementMessage", "🎉 Goal achieved! You earned +50 XP.");
        } else {
            goalRepository.save(activeGoal);
        }

        if ("goalUpdated".equals(success)) {
            model.addAttribute("successMessage", "Goal updated successfully.");
        } else if ("goalReset".equals(success)) {
            model.addAttribute("successMessage", "New goal created successfully.");
        }

        if ("invalidTarget".equals(error)) {
            model.addAttribute("errorMessage", "Goal target must be between 1 and 4 courses.");
        } else if ("invalidDeadline".equals(error)) {
            model.addAttribute("errorMessage", "Please choose a future deadline.");
        }

        model.addAttribute("goal", activeGoal);
        model.addAttribute("deadlinePassed", deadlinePassed);
        return "goalTracker";
    }

    @PostMapping("/updateGoal")
    public String updateGoal(@RequestParam String target,
                             @RequestParam String deadline,
                             HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Goal activeGoal = goalRepository.findByUserIdAndActive(user.getId(), true);
        if (activeGoal == null) {
            return "redirect:/goalTracker";
        }

        String numericTarget = target.replaceAll("[^0-9]", "");
        int parsedTarget = numericTarget.isEmpty() ? 0 : Integer.parseInt(numericTarget);

        if (parsedTarget < 1 || parsedTarget > 4) {
            return "redirect:/goalTracker?error=invalidTarget";
        }

        LocalDateTime parsedDeadline;
        try {
            parsedDeadline = LocalDateTime.parse(deadline);
        } catch (Exception e) {
            return "redirect:/goalTracker?error=invalidDeadline";
        }

        if (!parsedDeadline.isAfter(LocalDateTime.now())) {
            return "redirect:/goalTracker?error=invalidDeadline";
        }

        activeGoal.setTarget(parsedTarget);
        activeGoal.setCompletedCount(0);
        activeGoal.setReward("+50 XP");
        activeGoal.setRewardClaimed(false);
        activeGoal.setActive(true);
        activeGoal.setCreatedAt(LocalDateTime.now());
        activeGoal.setDeadline(parsedDeadline);

        goalRepository.save(activeGoal);
        return "redirect:/goalTracker?success=goalUpdated";
    }

    @PostMapping("/resetGoal")
    public String resetGoal(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Goal activeGoal = goalRepository.findByUserIdAndActive(user.getId(), true);

        if (activeGoal == null) {
            activeGoal = new Goal();
            activeGoal.setUser(user);
        }

        activeGoal.setTarget(1);
        activeGoal.setCompletedCount(0);
        activeGoal.setReward("+50 XP");
        activeGoal.setRewardClaimed(false);
        activeGoal.setActive(true);
        activeGoal.setCreatedAt(LocalDateTime.now());
        activeGoal.setDeadline(LocalDateTime.now().plusDays(1));

        goalRepository.save(activeGoal);
        return "redirect:/goalTracker?success=goalReset";
    }
}