package com.nyanja.online_quiz.services;

import com.nyanja.online_quiz.model.Question;
import com.nyanja.online_quiz.model.Quiz;
import com.nyanja.online_quiz.repositories.QuestionRepo;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionService {


    @Autowired
    private QuestionRepo questionRepo;
    //private static final Logger logger = LoggerFactory.getLogger(AttemptService.class);
    private static final Logger logger = (Logger) LogManager.getLogger(QuestionService.class);
    public List<Question> getAllQuestions() {
        logger.info("Fetching all questions");
        return questionRepo.findAll();
    }

    public List<Question> getAllQuestionsByQuiz(Quiz quiz) {
        logger.info("Getting questions that belong to the same quiz");
        return questionRepo.findAllByQuiz(quiz);
    }
    public Question getQuestionById(long id) {
        logger.info("Getting question by ID");
        return questionRepo.findById(id).orElse(null);
    }

    public Question createQuestion(Question question) {
        logger.info("Creating question");
        return questionRepo.save(question);
    }

    public void updateQuestion(long id, Question question) {
        if (questionRepo.existsById(id)) {
            logger.info("Updating question");
            question.setId(id);
            questionRepo.save(question);
        }
    }

    public void deleteQuestion(long id) {
        logger.info("Deleting question");
        questionRepo.deleteById(id);
    }


}
