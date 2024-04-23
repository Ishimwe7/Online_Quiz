package com.nyanja.online_quiz.model;

import jakarta.persistence.*;

@Entity
public class Option {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String option;
    private Boolean isAnswer;
    @ManyToOne
    private Question question;

    public Option() {
    }

    public Option(long id) {
        this.id = id;
    }

    public Option(long id, String option, Boolean isAnswer) {
        this.id = id;
        this.option = option;
        this.isAnswer=isAnswer;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getOption() {
        return option;
    }

    public Boolean getAnswer() {
        return isAnswer;
    }

    public void setAnswer(Boolean answer) {
        isAnswer = answer;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public void setOption(String option) {
        this.option = option;
    }
}
