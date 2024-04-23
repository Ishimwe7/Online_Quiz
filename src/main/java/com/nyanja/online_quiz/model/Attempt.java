package com.nyanja.online_quiz.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Attempt {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    private User user;
    @ManyToOne
    private Quiz quiz;
    private int marksObtained;

    public Attempt() {
    }

    public Attempt(Long id) {
        this.id = id;
    }

    public Attempt(int marksObtained) {
        this.marksObtained = marksObtained;
    }

    public Attempt(Long id, User user, Quiz quiz, int marksObtained) {
        this.id = id;
        this.user = user;
        this.quiz = quiz;
        this.marksObtained = marksObtained;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public int getMarksObtained() {
        return marksObtained;
    }

    public void setMarksObtained(int marksObtained) {
        this.marksObtained = marksObtained;
    }
}
