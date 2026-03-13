package com.example.fdarnacuisine;

import com.example.fdarnacuisine.Model.Repas;
import com.example.fdarnacuisine.Model.User;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Profile;

@SpringBootApplication
public class FdarnaCuisineApplication {

	public static void main(String[] args) {
		SpringApplication.run(FdarnaCuisineApplication.class, args);
	}

	@Bean
	@Profile("fly")
	public CommandLineRunner seedData(RepasRepository repasRepository, UserRepository userRepository) {
		return args -> {
			if (repasRepository.count() == 0) {
				repasRepository.save(new Repas(
						"Tajine de poulet",
						65.00,
						"Délicieux tajine de poulet aux olives et citron confit",
						"https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=500&auto=format"
				));
				repasRepository.save(new Repas(
						"Couscous royal",
						80.00,
						"Couscous avec légumes, poulet et merguez",
						"https://images.unsplash.com/photo-1453831362806-3d5577f014a4?w=500&auto=format"
				));
				repasRepository.save(new Repas(
						"Pastilla au poulet",
						75.00,
						"Pastilla sucrée-salée au poulet et amandes",
						"https://images.unsplash.com/photo-1604329760661-e71dc83f8f26?w=500&auto=format"
				));
				repasRepository.save(new Repas(
						"Harira",
						35.00,
						"Soupe marocaine traditionnelle",
						"https://images.unsplash.com/photo-1547592166-23ac45744acd?w=500&auto=format"
				));
				repasRepository.save(new Repas(
						"Poisson grillé",
						90.00,
						"Poisson frais grillé avec sauce chermoula",
						"https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=500&auto=format"
				));
				repasRepository.save(new Repas(
						"Mechoui d'agneau",
						120.00,
						"Agneau rôti lentement aux épices",
						"https://images.unsplash.com/photo-1544025162-d76694265947?w=500&auto=format"
				));
			}

			if (userRepository.count() == 0) {
				User admin = new User();
				admin.setFullname("Admin");
				admin.setEmail("admin@fdarna.com");
				admin.setPassword("admin");
				admin.setRole("ADMIN");
				userRepository.save(admin);

				User user1 = new User();
				user1.setFullname("User1");
				user1.setEmail("user1@email.com");
				user1.setPassword("user1");
				user1.setRole("USER");
				userRepository.save(user1);
			}
		};
	}

}
