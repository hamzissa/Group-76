package com.example.group76.controller;

import com.example.group76.model.User;
import com.example.group76.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegisterController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/register")
    public String handleRegister(@RequestParam String email, 
                                 @RequestParam String password, 
                                 @RequestParam String confirm) {
        if (password.equals(confirm)) {
            User user = new User();
            user.setEmail(email);
            user.setPassword(password);
            userRepository.save(user);
            return "redirect:/login";
        }
        return "redirect:/login?error=mismatch";
    }
}