package com.example.fdarnacuisine.config;

import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletRegistration;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;

/**
 * Force le MultipartConfigElement sur le DispatcherServlet au démarrage.
 * S'exécute en dernier pour que le DispatcherServlet soit déjà enregistré.
 */
@Configuration
public class MultipartServletConfig {

    private static final long MAX = 100L * 1024 * 1024; // 100 MB

    @Bean
    @Order(Ordered.LOWEST_PRECEDENCE)
    public ServletContextInitializer multipartConfigInitializer() {
        return (ServletContext context) -> {
            ServletRegistration.Dynamic dispatcher = (ServletRegistration.Dynamic) context.getServletRegistration("dispatcherServlet");
            if (dispatcher != null) {
                MultipartConfigElement config = new MultipartConfigElement(
                        System.getProperty("java.io.tmpdir", ""),
                        MAX, MAX, 0);
                dispatcher.setMultipartConfig(config);
            }
        };
    }
}
