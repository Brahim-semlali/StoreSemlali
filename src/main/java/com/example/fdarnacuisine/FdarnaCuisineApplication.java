package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.User;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class FdarnaCuisineApplication {

	public static void main(String[] args) {
		SpringApplication.run(FdarnaCuisineApplication.class, args);
	}

	/** Crée un compte admin au premier démarrage si aucun admin n'existe. */
	@Bean
	public CommandLineRunner seedAdminIfNeeded(UserRepository userRepository) {
		return args -> {
			if (userRepository.countByRole("ADMIN") == 0) {
				User admin = new User();
				admin.setFullname("Admin");
				admin.setEmail("admin@storesemlali.com");
				admin.setPassword("admin");
				admin.setRole("ADMIN");
				userRepository.save(admin);
			}
		};
	}

}
