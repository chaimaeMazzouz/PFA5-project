package com.pfa.servicedemandes;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
//@EnableDiscoveryClient
public class ServicedemandesApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServicedemandesApplication.class, args);
	}

}
