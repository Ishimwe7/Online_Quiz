package com.nyanja.online_quiz.services;

import com.nyanja.online_quiz.model.Quiz;
import com.nyanja.online_quiz.model.User;
import com.nyanja.online_quiz.repositories.QuizRepo;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuizService {

    @Autowired
    private QuizRepo quizRepo;
    //private static final Logger logger = LoggerFactory.getLogger(AttemptService.class);
    private static final Logger logger = (Logger) LogManager.getLogger(QuestionService.class);
    public List<Quiz> getAllQuizzes() {
        logger.info("Fetching all quizzes");
        return quizRepo.findAll();
    }

    public Quiz getQuizById(long id) {
        logger.info("Getting quiz by ID");
        return quizRepo.findById(id).orElse(null);
    }
    public List<Quiz> getQuizzesByOwner(User user) {
        logger.info("Getting quizzes that belong to the same owner");
        return quizRepo.findQuizzesByOwner(user);
    }

    public Quiz createQuiz(Quiz quiz) {
        logger.info("Creating Quiz");
        return quizRepo.save(quiz);
    }

    public Quiz updateQuiz(long id, Quiz quiz) {
        if (quizRepo.existsById(id)) {
            logger.info("Updating Quiz");
            quiz.setId(id);
            quizRepo.save(quiz);
            return quiz;
        }
        return null;
    }

    public void deleteQuiz(long id) {
        logger.info("Deleting Quiz");
        quizRepo.deleteById(id);
    }

}
