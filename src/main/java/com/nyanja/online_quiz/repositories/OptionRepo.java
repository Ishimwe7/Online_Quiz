package com.nyanja.online_quiz.repositories;

import com.nyanja.online_quiz.model.Option;
import com.nyanja.online_quiz.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OptionRepo extends JpaRepository<Option, Long> {
    public List<Option> findOptionsByQuestion(Question question);
}
