package com.example.demo;

import com.example.demo.entity.Account;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class LoadDatabase {
    @Bean
    CommandLineRunner initDatabase(AccountRepository repository) {
        return args -> {
            System.out.println(repository.save(new Account("user1", "1234")));
            System.out.println(repository.save(new Account("user2", "222222")));
            System.out.println(repository.save(new Account("user3", "313124")));
        };
    }
}
