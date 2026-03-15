package com.example.fdarnacuisine.Controller;

import com.example.fdarnacuisine.NotificationRepository;
import com.example.fdarnacuisine.Model.Notification;
import com.example.fdarnacuisine.Model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class NotificationController {

    @Autowired
    private NotificationRepository notificationRepository;

    @GetMapping("/notifications")
    public String listNotifications(HttpSession session, ModelMap model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        List<Notification> notifications = notificationRepository.findByUserOrderByCreatedAtDesc(user);
        model.addAttribute("notifications", notifications);
        return "notifications";
    }

    @PostMapping("/notifications/read")
    public String markAsRead(@RequestParam("id") Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        Notification notif = notificationRepository.findById(id).orElse(null);
        if (notif != null && notif.getUser().getId().equals(user.getId())) {
            notif.setRead(true);
            notificationRepository.save(notif);
        }
        return "redirect:/notifications";
    }

    @PostMapping("/notifications/read-all")
    public String markAllAsRead(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        List<Notification> list = notificationRepository.findByUserOrderByCreatedAtDesc(user);
        for (Notification n : list) {
            n.setRead(true);
            notificationRepository.save(n);
        }
        return "redirect:/notifications";
    }
}
