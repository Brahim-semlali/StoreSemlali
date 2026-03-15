package com.example.store.config;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.example.store.NotificationRepository;
import com.example.store.Model.User;

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
