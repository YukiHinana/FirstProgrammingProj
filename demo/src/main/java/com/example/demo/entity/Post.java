package com.example.demo.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Post {
    @Id
    @GeneratedValue
    private Long id;
    private String title;
    private String body;

    @ManyToOne
    private Account author;

//    @OneToMany
//    private List<Comment> commentList;

    public Post() {}

    public Post(String title, String body, Account author) {
        this.title = title;
        this.body = body;
        this.author = author;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public Account getAuthor() {
        return author;
    }

    public void setAuthor(Account author) {
        this.author = author;
    }

//    public List<Comment> getCommentList() {
//        return commentList;
//    }
//
//    public void setCommentList(List<Comment> commentList) {
//        this.commentList = commentList;
//    }
}
