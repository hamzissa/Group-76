package com.example.group76.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.example.group76.model.User;
import com.example.group76.repository.UserRepository;

@Controller
public class RegisterController {

	private final UserRepository userRepository;

	public RegisterController(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@GetMapping("/register")
	public String showRegister() {
		return "register";
	}

	@PostMapping("/register")
	public String handleRegister(@RequestParam String email, @RequestParam String password,
			@RequestParam(name = "confirm") String confirmPassword, Model model) {

		if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
			model.addAttribute("error", "All fields are required for registration.");
			return "register";
		}

		if (!password.equals(confirmPassword)) {
			model.addAttribute("error", "Passwords do not match!");
			return "register";
		}

		if (userRepository.findByEmail(email) != null) {
			model.addAttribute("error", "User with this email already exists.");
			return "register";
		}

		User newUser = new User(email, password);
		userRepository.save(newUser);

		model.addAttribute("message", "Registration successful! Please login.");
		return "login";
	}
}
