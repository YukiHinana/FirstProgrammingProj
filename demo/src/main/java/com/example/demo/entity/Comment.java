package com.example.demo.entity;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;

public class Comment {
    @Id
    @GeneratedValue
    private Long id;
    private String body;

    @OneToOne
    private Account author;
}
