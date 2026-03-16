package com.example.group76.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;
import com.example.group76.model.User;
import com.example.group76.model.Goal;
import com.example.group76.repository.GoalTrackerRepository;

@Controller
public class GoalTrackerController {

    private final GoalTrackerRepository goalRepository;

    public GoalTrackerController(GoalTrackerRepository goalRepository) {
        this.goalRepository = goalRepository;
    }

    @GetMapping("/goalTracker")
    public String showGoalTracker(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Goal activeGoal = goalRepository.findByUserIdAndActive(user.getId(), true);
        
        if (activeGoal == null) {
            activeGoal = new Goal();
            activeGoal.setUser(user);
            activeGoal.setTarget(3);
            activeGoal.setTimeframe("In One Day");
            activeGoal.setReward("Watch a Movie");
            activeGoal.setActive(true);
            goalRepository.save(activeGoal);
        }

        model.addAttribute("goal", activeGoal);
        // CHANGE: return "GoalTracker" instead of "goalTracker" 
        // to match your file: WEB-INF/jsp/GoalTracker.jsp
        return "GoalTracker"; 
    }

    @PostMapping("/updateGoal")
    public String updateGoal(@RequestParam String target, 
                            @RequestParam String timeframe, 
                            @RequestParam String reward, 
                            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Goal activeGoal = goalRepository.findByUserIdAndActive(user.getId(), true);
        
        String numericTarget = target.replaceAll("[^0-9]", "");
        activeGoal.setTarget(numericTarget.isEmpty() ? 0 : Integer.parseInt(numericTarget));
        activeGoal.setTimeframe(timeframe);
        activeGoal.setReward(reward);
        
        goalRepository.save(activeGoal);
        return "redirect:/goalTracker";
    }

    @PostMapping("/addCompletedItem")
    public String addCompletedItem(@RequestParam(required = false) String itemName, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Goal activeGoal = goalRepository.findByUserIdAndActive(user.getId(), true);
        if (activeGoal != null) {
            activeGoal.setCompletedCount(activeGoal.getCompletedCount() + 1);
            goalRepository.save(activeGoal);
        }
        
        return "redirect:/goalTracker";
    }
}