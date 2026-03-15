package com.example.store.config;

import org.springframework.boot.tomcat.servlet.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Force la limite POST Tomcat à une valeur élevée pour éviter HTTP 413
 * lors de l'upload d'images (admin produit). Par défaut Tomcat limite à 2 MB.
 */
@Configuration
public class TomcatConfig {

    private static final int MAX_POST_SIZE_BYTES = 100 * 1024 * 1024; // 100 MB

    @Bean
    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> tomcatMaxPostSizeCustomizer() {
        return factory -> factory.addConnectorCustomizers(connector -> {
            connector.setMaxPostSize(MAX_POST_SIZE_BYTES);
        });
    }
}
