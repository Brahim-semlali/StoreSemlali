package com.example.fdarnacuisine.Controller;

import com.example.fdarnacuisine.Model.User;
import com.example.fdarnacuisine.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class AuthentifController {

    private static final Logger log = LoggerFactory.getLogger(AuthentifController.class);

    @GetMapping("/login")
    public String Log(){
        return "login";
    }

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        ModelMap model,
                        HttpSession session) {

        User user = userRepository.findByEmail(email);

        if(user != null && user.getPassword().equals(password) && user.getRole().equals("USER")) {
            session.setAttribute("user", user);
            log.info("POST /login — connexion USER ok email={} userId={}", email, user.getId());
            return "redirect:/home";
        } else if (user != null && user.getPassword().equals(password) && user.getRole().equals("ADMIN")) {
            session.setAttribute("user", user);
            log.info("POST /login — connexion ADMIN ok email={} userId={}", email, user.getId());
            return "redirect:/admin";
        }

        log.warn("POST /login — échec email={}", email);
        model.addAttribute("error","Email ou password incorrect");
        return "login";
    }

    @GetMapping("/signup")
    public String Singup(){
        return "signup";
    }

    @PostMapping("/signup")
    public String sign(@RequestParam String fullname,  // doit correspondre au JSP
                       @RequestParam String email,
                       @RequestParam String password,
                       @RequestParam String confirmPassword,
                       ModelMap model) {


        if (!password.equals(confirmPassword)) {
            log.warn("POST /signup — mots de passe différents email={}", email);
            model.put("error", "Passwords do not match");
            return "signup";
        }

        // Vérifier si email existe
        User existingUser = userRepository.findByEmail(email);
        if(existingUser != null){
            log.warn("POST /signup — email déjà utilisé email={}", email);
            model.put("error", "Email already registered");
            return "signup";
        }

        User user = new User();
        user.setFullname(fullname);  // correspondance parfaite
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("USER");

        userRepository.save(user);
        log.info("POST /signup — compte créé email={} userId={}", email, user.getId());

        // Redirection vers login
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        log.info("GET /logout — déconnexion");
        session.invalidate();
        return "redirect:/home";
    }
}
