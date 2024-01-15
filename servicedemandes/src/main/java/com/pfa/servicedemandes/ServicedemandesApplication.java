package com.pfa.servicedemandes;

import org.springframework.boot.SpringApplication;	
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@EnableDiscoveryClient
@SpringBootApplication
@EnableFeignClients
public class ServicedemandesApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServicedemandesApplication.class, args);
	}
	/*
	@FeignClient(name = "NOTIFICATION-SERVICE")
	public interface NotificationService {
		@PostMapping("/api/send-text")
		public String sendTextEmail(@RequestBody com.pfa.servicedemandes.model.EmailMessage emailMessage);
	}*/

}
