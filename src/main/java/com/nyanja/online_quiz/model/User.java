package com.nyanja.online_quiz.model;

import jakarta.persistence.*;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long user_id;
    private String username;
    private String email;
    private boolean isAdmin;
    private String password;
    @OneToOne
    private Attempt attempt;

    public User() {
    }

    public User(long user_id) {
        this.user_id = user_id;
    }

    public User(long user_id, String username, String email,boolean isAdmin, String password, Attempt attempt) {
        this.user_id = user_id;
        this.username = username;
        this.email = email;
        this.isAdmin=isAdmin;
        this.password = password;
        this.attempt=attempt;
    }

    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Attempt getAttempt() {
        return attempt;
    }

    public void setAttempt(Attempt attempt) {
        this.attempt = attempt;
    }
}


