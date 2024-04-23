package com.nyanja.online_quiz;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@ServletComponentScan
@EnableJpaRepositories(basePackages = "com.nyanja.online_quiz.repositories")
@EnableTransactionManagement
@SpringBootApplication
public class OnlineQuizApplication {

    public static void main(String[] args) {
        SpringApplication.run(OnlineQuizApplication.class, args);
    }

}
