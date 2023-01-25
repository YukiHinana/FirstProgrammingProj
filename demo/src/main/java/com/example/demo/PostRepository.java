package com.example.demo;

import com.example.demo.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

interface PostRepository extends JpaRepository<Post, Long> {

}
