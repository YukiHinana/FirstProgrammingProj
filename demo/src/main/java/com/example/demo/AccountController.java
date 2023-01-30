package com.example.demo;

import com.example.demo.entity.Account;
import com.example.demo.entity.Token;
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
        return new ResponseWrapper<>(true, accountRepository.findAll());
    }

    @PostMapping("/")
    public ResponseWrapper<?> register(@RequestBody AccountRequest request) {
        Account newAccount = new Account(request.getUsername(), request.getPassword());
        Optional<Account> findAccount = accountRepository.findByUsername(request.getUsername());
        if (findAccount.isPresent()) {
            return new ResponseWrapper<String>(false, "Username already exists!");
        }
        return new ResponseWrapper<>(true, accountRepository.save(newAccount));
    }

    @PostMapping("/login")
    public ResponseWrapper<?> login(@RequestBody AccountRequest request) {
        String username = request.getUsername();
        Optional<Account> account = accountRepository.findByUsername(username);
        if (account.isPresent()) {
            if (account.get().getPassword().equals(request.getPassword())) {
                String uuid = UUID.randomUUID().toString();
                tokenRepository.save(new Token(uuid, account.get()));
                return new ResponseWrapper<>(true, uuid);
            }
        }
        return new ResponseWrapper<>(false, "Incorrect username or password");
    }
}
