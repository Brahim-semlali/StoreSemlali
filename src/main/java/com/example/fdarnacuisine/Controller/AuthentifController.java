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

@Controller
public class AuthentifController {

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
            return "redirect:/home";
        } else if (user != null && user.getPassword().equals(password) && user.getRole().equals("ADMIN")) {
            session.setAttribute("user", user);
            return "redirect:/admin/catalogue";
        }

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
            model.put("error", "Passwords do not match");
            return "signup";
        }

        // Vérifier si email existe
        User existingUser = userRepository.findByEmail(email);
        if(existingUser != null){
            model.put("error", "Email already registered");
            return "signup";
        }

        User user = new User();
        user.setFullname(fullname);  // correspondance parfaite
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("USER");

        userRepository.save(user);

        // Redirection vers login
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/home";
    }
}
