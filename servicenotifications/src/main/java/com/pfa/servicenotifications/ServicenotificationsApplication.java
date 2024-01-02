package com.pfa.servicenotifications;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
@SpringBootApplication(exclude={DataSourceAutoConfiguration.class})

public class ServicenotificationsApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServicenotificationsApplication.class, args);
	}

}
