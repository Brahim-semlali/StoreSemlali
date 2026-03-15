package com.example.fdarnacuisine.config;

import com.example.fdarnacuisine.Model.User;
import com.example.fdarnacuisine.NotificationRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class NotificationModelAdvice {

    @Autowired
    private NotificationRepository notificationRepository;

    @ModelAttribute
    public void addNotificationCount(HttpSession session, ModelMap model) {
        Object userObj = session.getAttribute("user");
        model.addAttribute("user", userObj);
        if (userObj instanceof User user) {
            long count = notificationRepository.countByUserAndReadFalse(user);
            model.addAttribute("notificationCount", count);
        } else {
            model.addAttribute("notificationCount", 0L);
        }
    }
}
