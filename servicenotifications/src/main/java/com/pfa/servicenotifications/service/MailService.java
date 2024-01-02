package com.pfa.servicenotifications.service;

import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sendgrid.Content;
import com.sendgrid.Email;
import com.sendgrid.Mail;
import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;

@Service
public class MailService {
    private static final Logger logger = LoggerFactory.getLogger(MailService.class);

    @Value("${sendgrid.api.key}")
    private String apiKey;

    public String sendTextEmail(String toEmail, String subject, String contentText) {
        Email from = new Email("mazzouz.chaimae.dev@gmail.com");
        Email to = new Email(toEmail);
        Content content = new Content("text/plain", contentText);
        Mail mail = new Mail(from, subject, to, content);

        SendGrid sg = new SendGrid(apiKey);
        Request request = new Request();
        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            Response response = sg.api(request);
            logger.info("Email sent with status code: {}", response.getStatusCode());
            return response.getBody();
        } catch (IOException ex) {
            logger.error("Error sending email: {}", ex.getMessage());
            throw new RuntimeException("Error sending email", ex);
        }
    }
}
