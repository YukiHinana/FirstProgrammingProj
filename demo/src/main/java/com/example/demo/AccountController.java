package com.example.demo;

import com.example.demo.entity.Account;
import com.example.demo.entity.Token;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/account")
public class AccountController {
    private final AccountRepository accountRepository;
    private final TokenRepository tokenRepository;

    public AccountController(AccountRepository accountRepository, TokenRepository tokenRepository) {
        this.accountRepository = accountRepository;
        this.tokenRepository = tokenRepository;
    }

    @GetMapping("/all")
    public ResponseEntity<ResponseWrapper<List<Account>>> getAccounts() {
        return ResponseEntity.ok().body(new ResponseWrapper<>(accountRepository.findAll()));
    }

    @PostMapping("/")
    public ResponseEntity<ResponseWrapper<?>> register(@RequestBody AccountRequest request) {
        if (request.getUsername().isEmpty() || request.getUsername() == null
                || request.getPassword().isEmpty() || request.getPassword() == null) {
            return ResponseEntity.badRequest().body(new ResponseWrapper<>("Username and password required"));
        }
        Account newAccount = new Account(request.getUsername(), request.getPassword());
        Optional<Account> findAccount = accountRepository.findByUsername(request.getUsername());
        if (findAccount.isPresent()) {
            return ResponseEntity.badRequest().body(new ResponseWrapper<>("Username already exists!"));
        }
        return ResponseEntity.ok().body(new ResponseWrapper<>(accountRepository.save(newAccount)));
    }

    @PostMapping("/login")
    public ResponseEntity<ResponseWrapper<?>> login(@RequestBody AccountRequest request) {
        String username = request.getUsername();
        System.out.println(request.getUsername());
        System.out.println(request.getPassword());
        if (request.getUsername().isEmpty() || request.getUsername() == null
                || request.getPassword().isEmpty() || request.getPassword() == null) {
            System.out.println("aaa");
            return ResponseEntity.badRequest().body(new ResponseWrapper<>("Username and password required"));
        }
        Optional<Account> account = accountRepository.findByUsername(username);
        if (account.isPresent()) {
            if (account.get().getPassword().equals(request.getPassword())) {
                String uuid = UUID.randomUUID().toString();
                tokenRepository.save(new Token(uuid, account.get()));
                return ResponseEntity.ok().body(new ResponseWrapper<>(uuid));
            }
        }
        return ResponseEntity.badRequest().body(new ResponseWrapper<>("Incorrect username or password"));
    }


}
