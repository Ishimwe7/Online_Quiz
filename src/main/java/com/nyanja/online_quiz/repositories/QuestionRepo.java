package com.nyanja.online_quiz.repositories;

import com.nyanja.online_quiz.model.Question;
import com.nyanja.online_quiz.model.Quiz;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface QuestionRepo extends JpaRepository<Question, Long> {
    List<Question> findAllByQuiz(Quiz quiz);
}
