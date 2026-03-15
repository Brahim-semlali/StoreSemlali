package com.example.fdarnacuisine.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import jakarta.servlet.http.HttpServletRequest;

/**
 * Log toutes les exceptions non gérées des contrôleurs (et du rendu de vue si propagées).
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(Exception.class)
    public String handleException(Exception ex, HttpServletRequest request) {
        String uri = request.getRequestURI();
        String query = request.getQueryString();
        String fullUrl = query != null ? uri + "?" + query : uri;
        log.error("[GLOBAL] Exception sur {} : {} - {}", fullUrl, ex.getClass().getName(), ex.getMessage(), ex);
        return "redirect:/home";
    }
}
