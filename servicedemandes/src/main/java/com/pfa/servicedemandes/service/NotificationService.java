package com.pfa.servicedemandes.service;

import com.pfa.servicedemandes.model.EmailMessage;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(name = "NOTIFICATION-SERVICE")
public interface NotificationService {
    @PostMapping("/api/send-text")
    public String sendTextEmail(@RequestBody EmailMessage emailMessage);
}