package com.example.demo;

import com.example.demo.entity.Account;
import com.example.demo.entity.Token;
import org.springframework.http.HttpStatus;
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
    public ResponseWrapper<List<Account>> getAccounts() {
        return new ResponseWrapper<>(HttpStatus.OK, accountRepository.findAll());
    }

    @PostMapping("/")
    public ResponseWrapper<?> register(@RequestBody AccountRequest request) {
        if (request.getUsername().isEmpty() || request.getUsername() == null
                || request.getPassword().isEmpty() || request.getPassword() == null) {
            return new ResponseWrapper<>(HttpStatus.BAD_REQUEST, "Username and password required");
        }
        Account newAccount = new Account(request.getUsername(), request.getPassword());
        Optional<Account> findAccount = accountRepository.findByUsername(request.getUsername());
        if (findAccount.isPresent()) {
            return new ResponseWrapper<>(HttpStatus.BAD_REQUEST, "Username already exists!");
        }
        return new ResponseWrapper<>(HttpStatus.OK, accountRepository.save(newAccount));
    }

    @PostMapping("/login")
    public ResponseWrapper<?> login(@RequestBody AccountRequest request) {
        String username = request.getUsername();
        if (request.getUsername().isEmpty() || request.getUsername() == null
                || request.getPassword().isEmpty() || request.getPassword() == null) {
            return new ResponseWrapper<>(HttpStatus.BAD_REQUEST, "Username and password required");
        }
        Optional<Account> account = accountRepository.findByUsername(username);
        if (account.isPresent()) {
            if (account.get().getPassword().equals(request.getPassword())) {
                String uuid = UUID.randomUUID().toString();
                tokenRepository.save(new Token(uuid, account.get()));
                return new ResponseWrapper<>(HttpStatus.OK, uuid);
            }
        }
        return new ResponseWrapper<>(HttpStatus.BAD_REQUEST, "Incorrect username or password");
    }


}
