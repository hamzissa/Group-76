package com.example.group76.controller;

import com.example.group76.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.example.group76.repository.UserRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/friends")
public class FriendController {

    private final UserRepository userRepository;

    public FriendController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Transactional
    @PostMapping("/add")
    public String addFriend(@RequestParam Long friendId, HttpSession session, RedirectAttributes redirectAttributes) {
        User detached_user = (User) session.getAttribute("user");
        if (detached_user == null) {
            return "redirect:/login";
        }
        User user = userRepository.findById(detached_user.getId()).orElse(null);
        if (user == null) {
            return "redirect:/login";
        }
        User friend = userRepository.findById(friendId).orElse(null);
        if (friend == null) {
            return "redirect:/dashboard";
        }
        if (!user.getFriends().contains(friend)) {
            user.getFriends().add(friend);
        }
        userRepository.save(user);
        redirectAttributes.addFlashAttribute("successMessage", "Successfully added friend");
        return "redirect:/friends/find";
    }

    @Transactional
    @PostMapping("/remove")
    public String removeFriend(@RequestParam Long friendId, HttpSession session, RedirectAttributes redirectAttributes) {
        User detached_user = (User) session.getAttribute("user");
        if (detached_user == null) {
            return "redirect:/login";
        }
        User user = userRepository.findById(detached_user.getId()).orElse(null);
        if (user == null) {
            return "redirect:/login";
        }
        User friend = userRepository.findById(friendId).orElse(null);
        if (friend == null) {
            return "redirect:/friends/find";
        }
        if (!user.getFriends().contains(friend)) {
            return "redirect:/friends/find";
        } else {
            user.getFriends().remove(friend);
            userRepository.save(user);
        }
        redirectAttributes.addFlashAttribute("successMessage", "Friend Successfully Removed");
        return "redirect:/friends/list";
    }

    @Transactional
    @GetMapping("/find")
    public String findFriends(@RequestParam(required = false) String friendID, Model m, HttpSession session, RedirectAttributes redirectAttributes) {
        User detached_user = (User) session.getAttribute("user");
        if (detached_user == null) {
            return "redirect:/login";
        }
        User user = userRepository.findById(detached_user.getId()).orElse(null);
        if (user == null) {
            return "redirect:/login";
        }

        List<User> friends = user.getFriends();
        List<User> allUsers = userRepository.findAll();
        List<User> filtered_Users = new ArrayList<>();

        if (friendID == null) {
            for (User users : allUsers) {
                if (!users.getId().equals(user.getId()) && !friends.contains(users)) {
                    filtered_Users.add(users);
                }
            }
            m.addAttribute("userList", filtered_Users);
            return "findUsers";
        } else {
            long parsedID = 0;
            try {
                parsedID = Long.parseLong(friendID);
                User friend = userRepository.findById(parsedID).orElse(null);
                if (friend == null) {
                    redirectAttributes.addFlashAttribute("errorMessage", "The friend ID you have typed does not exist!");
                    return "redirect:/friends/find";
                }
                if (friend != user && !user.getFriends().contains(friend)) {
                    filtered_Users.add(friend);
                }
                m.addAttribute("userList", filtered_Users);
                return "findUsers";
            } catch (NumberFormatException e) {
                redirectAttributes.addFlashAttribute("invalid_inputMessage", "The ID you have typed is in the incorrect format! Please type a combination of numbers from 0-9.");
                return "redirect:/friends/find";
            }
        }
    }

    @Transactional
    @GetMapping("/list")
    public String friendsList(Model m, HttpSession session) {
        User detached_user = (User) session.getAttribute("user");
        if (detached_user == null) {
            return "redirect:/login";
        }
        User user = userRepository.findById(detached_user.getId()).orElse(null);
        if (user == null) {
            return "redirect:/login";
        }
        m.addAttribute("friendList", user.getFriends());
        return "friendsList";
    }

    @Transactional
    @GetMapping("/leaderboard")
    public String friendsLeaderboard(Model m, HttpSession session){
        User detached_user = (User) session.getAttribute("user");
        if (detached_user == null) {
            return "redirect:/login";
        }

        User user = userRepository.findById(detached_user.getId()).orElse(null);
        if (user == null) {
            return "redirect:/login";
        }

        List<User> friends = user.getFriends();
        List<User> sorted = friends.stream().sorted((s1, s2) -> Integer.compare(s2.getXp(), s1.getXp())).toList();

        m.addAttribute("Leaderboard", sorted);
        return "friend_leaderboard";

    }


}
