package com.example.group76.controller;

import com.example.group76.model.CourseCompletion;
import com.example.group76.model.User;
import com.example.group76.repository.CourseCompletionRepository;
import com.example.group76.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class CompletionController {

    private final CourseCompletionRepository completionRepo;
    private final UserRepository userRepository;

    public CompletionController(CourseCompletionRepository completionRepo, UserRepository userRepository) {
        this.completionRepo = completionRepo;
        this.userRepository = userRepository;
    }

    @GetMapping("/completion")
    public String completionPage(@RequestParam(value = "sort", defaultValue = "recent") String sort,
                                 @RequestParam(value = "success", required = false) String success,
                                 @RequestParam(value = "error", required = false) String error,
                                 HttpSession session,
                                 Model model) {

        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        List<CourseCompletion> completions =
                new ArrayList<>(completionRepo.findByUserEmailOrderByCompletedAtDesc(user.getEmail()));

        if ("highest".equals(sort)) {
            completions.sort(Comparator.comparing(
                    c -> c.getRating() == null ? 0 : c.getRating(),
                    Comparator.reverseOrder()
            ));
        } else if ("lowest".equals(sort)) {
            completions.sort(Comparator.comparing(
                    c -> c.getRating() == null ? 6 : c.getRating()
            ));
        }

        Map<String, String> averageRatings = new LinkedHashMap<>();
        Map<String, Integer> ratingCounts = new LinkedHashMap<>();

        for (CourseCompletion completion : completions) {
            String courseName = completion.getCourseName();
            List<CourseCompletion> reviews = completionRepo.findByCourseNameAndRatingIsNotNull(courseName);

            if (reviews.isEmpty()) {
                averageRatings.put(courseName, "No ratings yet");
                ratingCounts.put(courseName, 0);
            } else {
                double avg = reviews.stream()
                        .mapToInt(CourseCompletion::getRating)
                        .average()
                        .orElse(0.0);

                averageRatings.put(courseName, String.format("%.1f", avg));
                ratingCounts.put(courseName, reviews.size());
            }
        }

        model.addAttribute("completions", completions);
        model.addAttribute("averageRatings", averageRatings);
        model.addAttribute("ratingCounts", ratingCounts);
        model.addAttribute("sort", sort);

        if ("courseCompleted".equals(success)) {
            model.addAttribute("successMessage", "Course completed successfully.");
        } else if ("reviewSaved".equals(success)) {
            model.addAttribute("successMessage", "Review saved successfully. You earned +10 XP.");
        } else if ("reviewUpdated".equals(success)) {
            model.addAttribute("successMessage", "Review updated successfully.");
        }

        if ("invalidRating".equals(error)) {
            model.addAttribute("errorMessage", "Rating must be between 1 and 5.");
        } else if ("commentTooShort".equals(error)) {
            model.addAttribute("errorMessage", "Comment must be at least 10 characters long.");
        } else if ("completionNotFound".equals(error)) {
            model.addAttribute("errorMessage", "You can only review a course after completing it.");
        }

        return "completion";
    }

    @PostMapping("/completion/mark")
    public String markCompleted(@RequestParam("courseName") String courseName,
                                HttpSession session) {

        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        String cleanCourseName = courseName == null ? "" : courseName.trim();
        if (cleanCourseName.isEmpty()) {
            return "redirect:/completion";
        }

        Optional<CourseCompletion> existing =
                completionRepo.findByUserEmailAndCourseName(user.getEmail(), cleanCourseName);

        if (existing.isEmpty()) {
            CourseCompletion cc = new CourseCompletion(
                    user.getEmail(),
                    cleanCourseName,
                    LocalDateTime.now()
            );
            completionRepo.save(cc);
        }

        return "redirect:/completion";
    }

    @PostMapping("/completion/review")
    public String submitReview(@RequestParam("courseName") String courseName,
                               @RequestParam("rating") int rating,
                               @RequestParam("comment") String comment,
                               HttpSession session) {

        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            return "redirect:/login";
        }

        String cleanComment = comment == null ? "" : comment.trim();

        if (rating < 1 || rating > 5) {
            return "redirect:/completion?error=invalidRating";
        }

        if (cleanComment.length() < 10) {
            return "redirect:/completion?error=commentTooShort";
        }

        Optional<CourseCompletion> completion =
                completionRepo.findByUserEmailAndCourseName(sessionUser.getEmail(), courseName);

        if (completion.isEmpty()) {
            return "redirect:/completion?error=completionNotFound";
        }

        CourseCompletion cc = completion.get();
        boolean firstReview = (cc.getRating() == null);

        cc.setRating(rating);
        cc.setComment(cleanComment);
        completionRepo.save(cc);

        if (firstReview) {
            User fullUser = userRepository.findByEmail(sessionUser.getEmail());
            if (fullUser != null) {
                fullUser.setXp(fullUser.getXp() + 10);
                userRepository.save(fullUser);
                session.setAttribute("user", fullUser);
            }
            return "redirect:/completion?success=reviewSaved";
        }

        return "redirect:/completion?success=reviewUpdated";
    }
}