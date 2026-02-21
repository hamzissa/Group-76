package com.example.group76.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;
import com.example.group76.model.User;

@Controller
public class LoginController {

	@GetMapping("/login")
	public String showLogin() {
		return "login";
	}

	@PostMapping("/login")
	public String handleLogin(@RequestParam String email, @RequestParam String password, 
			HttpSession session, Model model) {

		User userAttempt = new User(email, password);

		if ("test@example.com".equals(userAttempt.getEmail()) && "1234".equals(userAttempt.getPassword())) {
			session.setAttribute("user", userAttempt);
			return "redirect:/dashboard";
		} else {
			model.addAttribute("error", "Invalid email or password");
			return "login";
		}
	}
}
