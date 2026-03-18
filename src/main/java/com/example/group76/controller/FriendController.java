package com.example.group76.controller;

import com.example.group76.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.example.group76.repository.UserRepository;

import java.util.Optional;

@Controller
@RequestMapping("/friends")
public class FriendController {

    private final UserRepository userRepository;
    //Repository injection
    public FriendController(UserRepository userRepository){
        this.userRepository = userRepository;
    }

    @PostMapping("/add")
    public String addFriend(@RequestParam Long friendId, Model m, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null){
            return "redirect:/login";
        }
        User friend = userRepository.findById(friendId).orElse(null);
        if (friend == null){
            return "redirect:/dashboard";
        }
        if (!user.getFriends().contains(friend)) {user.getFriends().add(friend);}
        userRepository.save(user);
        return "redirect:/dashboard";
    }
}
