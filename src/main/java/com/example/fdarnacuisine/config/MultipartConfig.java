package com.example.fdarnacuisine.config;

import jakarta.servlet.MultipartConfigElement;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import java.io.File;

/**
 * Force les limites multipart (100 MB) pour éviter MaxUploadSizeExceededException.
 */
@Configuration
@ConditionalOnWebApplication
public class MultipartConfig {

    private static final long MAX_FILE_SIZE = 100L * 1024 * 1024;   // 100 MB
    private static final long MAX_REQUEST_SIZE = 100L * 1024 * 1024; // 100 MB
    private static final int FILE_SIZE_THRESHOLD = 0;

    @Bean
    @Primary
    public MultipartConfigElement multipartConfigElement() {
        String location = System.getProperty("java.io.tmpdir", "");
        return new MultipartConfigElement(location, MAX_FILE_SIZE, MAX_REQUEST_SIZE, FILE_SIZE_THRESHOLD);
    }
}
