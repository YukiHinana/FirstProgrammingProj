package com.example.demo;

import com.example.demo.entity.Account;
import com.example.demo.entity.Post;
import com.example.demo.entity.Token;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/posts")
public class PostController {
    private final PostRepository postRepository;
    private final AccountRepository accountRepository;
    private final TokenRepository tokenRepository;

    public PostController(PostRepository postRepository, AccountRepository accountRepository, TokenRepository tokenRepository) {
        this.postRepository = postRepository;
        this.accountRepository = accountRepository;
        this.tokenRepository = tokenRepository;
    }

    @GetMapping("/")
    public ResponseWrapper<List<Post>> getPosts() {
        return new ResponseWrapper<>(true, postRepository.findAll());
    }

    @PostMapping("/create")
    public ResponseWrapper<Post> create(@RequestBody PostRequest request,
                                        @RequestHeader("Authorization") String token) {
        Optional<Token> foundToken = tokenRepository.findByUuid(token);
        if (foundToken.isPresent()) {
            Account account = foundToken.get().getAccount();
            Post post = new Post(request.getTitle(), request.getBody(), account);
            return new ResponseWrapper<>(true, postRepository.save(post));
        }
        return new ResponseWrapper<>(false, null);
    }


}
