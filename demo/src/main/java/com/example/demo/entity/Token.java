package com.example.demo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Token {
    @Id
    @GeneratedValue
    private Long id;

    private String uuid;

    @ManyToOne
    private Account account;

    public Token() {
    }

    public Token(String uuid, Account account) {
        this.uuid = uuid;
        this.account = account;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }
}
