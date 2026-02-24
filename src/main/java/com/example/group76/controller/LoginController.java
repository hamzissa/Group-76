package com.example.group76.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;
import com.example.group76.model.User;
import com.example.group76.repository.UserRepository;

@Controller
public class LoginController {

	private final UserRepository userRepository;

	public LoginController(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@GetMapping("/login")
	public String showLogin() {
		return "login";
	}

	@PostMapping("/login")
	public String handleLogin(@RequestParam String email, @RequestParam String password, 
			HttpSession session, Model model) {

		User user = userRepository.findByEmail(email);

		if (user != null && user.getPassword().equals(password)) {
			session.setAttribute("user", user);
			return "redirect:/dashboard";
		} else {
			model.addAttribute("error", "Invalid email or password");
			return "login";
		}
	}
}
