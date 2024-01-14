package com.pfa.servicenotifications.controller;

import com.pfa.servicenotifications.dto.EmailMessage;	
import com.pfa.servicenotifications.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class MailController {

    @Autowired
    private MailService mailService;

    @PostMapping("/send-text")
    public String sendTextEmail(
            @RequestBody EmailMessage emailMessage) {
        return mailService.sendTextEmail(emailMessage.getTo(),emailMessage.getSubject(),emailMessage.getContent());
    }
}

