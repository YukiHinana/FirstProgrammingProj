package com.example.demo;

import com.example.demo.entity.Account;
import com.example.demo.entity.Post;
import com.example.demo.entity.Token;
import org.springframework.http.HttpStatus;
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
        return new ResponseWrapper<>(HttpStatus.OK, postRepository.findAll());
    }

    @GetMapping("/{id}")
    public ResponseWrapper<?> getPost(@PathVariable Long id) {
        Optional<Post> post = postRepository.findById(id);
        if (!post.isPresent()) {
            return new ResponseWrapper<>(HttpStatus.BAD_REQUEST, "Post does not exist");
        }
        return new ResponseWrapper<>(HttpStatus.OK, post.get());
    }

    @PostMapping("/create")
    public ResponseWrapper<?> create(@RequestBody PostRequest request,
                                        @RequestHeader("Authorization") String token) {
        Optional<Token> foundToken = tokenRepository.findByUuid(token);
        if (foundToken.isPresent()) {
            if (request.getTitle().isEmpty() || request.getTitle() == null
                    || request.getBody().isEmpty() || request.getBody() == null) {
                return new ResponseWrapper<>(HttpStatus.BAD_REQUEST, "Post title and content required");
            }
            Account account = foundToken.get().getAccount();
            Post post = new Post(request.getTitle(), request.getBody(), account);
            return new ResponseWrapper<>(HttpStatus.OK, postRepository.save(post));
        }
        return new ResponseWrapper<>(HttpStatus.BAD_REQUEST, null);
    }
}
