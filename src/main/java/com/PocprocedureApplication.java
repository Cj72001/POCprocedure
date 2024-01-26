package com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@EnableJpaRepositories(basePackages = "com.pocstoreprocedure.pocprocedure.repository")
@SpringBootApplication
public class PocprocedureApplication {

	public static void main(String[] args) {
		SpringApplication.run(PocprocedureApplication.class, args);
	}

}
