package com.example.group76;

import com.example.group76.model.User;
import com.example.group76.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class Group76Application {

	public static void main(String[] args) {
		SpringApplication.run(Group76Application.class, args);
	}

	@Bean
	public CommandLineRunner initData(UserRepository userRepository) {
		return args -> {
			if (userRepository.findByEmail("test@example.com") == null) {
				User testUser = new User("test@example.com", "1234");
				userRepository.save(testUser);
			}
		};
	}
}
