package com.nyanja.online_quiz.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String question;
    @ManyToOne
    private Quiz quiz;

    public Question() {
    }

    public Question(long id) {
        this.id = id;
    }

    public Question(long id, String question, Quiz quiz) {
        this.id = id;
        this.question=question;
        this.quiz = quiz;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }
}
