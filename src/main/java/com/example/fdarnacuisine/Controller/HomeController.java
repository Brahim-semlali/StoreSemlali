package com.example.fdarnacuisine.Controller;

import com.example.fdarnacuisine.Model.Repas;
import com.example.fdarnacuisine.Model.User;
import com.example.fdarnacuisine.Model.Visit;
import com.example.fdarnacuisine.RepasRepository;
import com.example.fdarnacuisine.VisitRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private RepasRepository repasRepository;

    @Autowired
    private VisitRepository visitRepository;

    @GetMapping("/")
    public String root(ModelMap model){
        return "redirect:/home";
    }

    @GetMapping("/home")
    public String home(ModelMap model, HttpServletRequest request, HttpSession session) {
        // Enregistrer une visite simple
        Visit visit = new Visit();
        visit.setVisitedAt(java.time.LocalDateTime.now());
        visit.setIp(request.getRemoteAddr());
        visit.setUserAgent(request.getHeader("User-Agent"));
        Object userObj = session.getAttribute("user");
        if (userObj instanceof User) {
            visit.setUser((User) userObj);
        }
        visitRepository.save(visit);

        List<Repas> repasList = repasRepository.findAll(); // récupère tous les repas
        model.addAttribute("repasList", repasList);
        return "home"; // home.jsp
    }
}