package com.example.demo;

import com.example.demo.entity.Account;
import com.example.demo.entity.Post;
import com.example.demo.entity.Token;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<ResponseWrapper<List<Post>>> getPosts() {
        return ResponseEntity.ok().body(new ResponseWrapper<>(postRepository.findAll()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ResponseWrapper<?>> getPost(@PathVariable Long id) {
        Optional<Post> post = postRepository.findById(id);
        if (!post.isPresent()) {
            return ResponseEntity.badRequest().body(new ResponseWrapper<>("Post does not exist"));
        }
        return ResponseEntity.ok().body(new ResponseWrapper<>(post.get()));
    }

    @PostMapping("/create")
    public ResponseEntity<ResponseWrapper<?>> create(@RequestBody PostRequest request,
                                        @RequestHeader("Authorization") String token) {
        Optional<Token> foundToken = tokenRepository.findByUuid(token);
        if (foundToken.isPresent()) {
            if (request.getTitle().isEmpty() || request.getTitle() == null
                    || request.getBody().isEmpty() || request.getBody() == null) {
                return ResponseEntity.badRequest().body(new ResponseWrapper<>("Post title and content required"));
            }
            Account account = foundToken.get().getAccount();
            Post post = new Post(request.getTitle(), request.getBody(), account);
            return ResponseEntity.ok().body(new ResponseWrapper<>(postRepository.save(post)));
        }
        return ResponseEntity.badRequest().body(new ResponseWrapper<>(null));
    }
}
