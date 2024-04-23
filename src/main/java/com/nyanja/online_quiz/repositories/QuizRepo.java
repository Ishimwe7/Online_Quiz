package com.nyanja.online_quiz.repositories;

import com.nyanja.online_quiz.model.Quiz;
import com.nyanja.online_quiz.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface QuizRepo extends JpaRepository<Quiz, Long> {
    public List<Quiz> findQuizzesByOwner(User user);
}
