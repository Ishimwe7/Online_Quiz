package com.nyanja.online_quiz.repositories;

import com.nyanja.online_quiz.model.Attempt;
import com.nyanja.online_quiz.model.Quiz;
import com.nyanja.online_quiz.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AttemptRepo extends JpaRepository<Attempt, Long> {
    public Attempt findAttemptByUserAndQuiz(User user, Quiz quiz);
}
