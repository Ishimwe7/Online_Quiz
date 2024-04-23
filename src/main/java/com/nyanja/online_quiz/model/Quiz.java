package com.nyanja.online_quiz.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Quiz {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String description;
    @ManyToOne
    private User owner;
    private Double duration;
    public Quiz() {
    }

    public Quiz(Long id) {
        this.id = id;
    }

    public Quiz(Long id, String title,String description, User owner, Double duration) {
        this.id = id;
        this.title=title;
        this.description=description;
        this.owner=owner;
        this.duration=duration;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public Double getDuration(){
        return duration;
    }
    public void setDuration(Double duration){
        this.duration=duration;
    }
}

