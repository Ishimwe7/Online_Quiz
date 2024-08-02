package com.nyanja.online_quiz.services;

import com.nyanja.online_quiz.model.*;
import com.nyanja.online_quiz.repositories.AttemptRepo;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttemptService {

    @Autowired
    private AttemptRepo attemptRepo;
    //private static final Logger logger = LoggerFactory.getLogger(AttemptService.class);
    private static final Logger logger = (Logger) LogManager.getLogger(AttemptService.class);
    public List<Attempt> getAllAttempts() {
        logger.info("Fetching all attempts");
        return attemptRepo.findAll();
    }

    public Attempt getAttemptById(long id) {
        logger.info("Fetching attempt by ID: {}", id);
        return attemptRepo.findById(id).orElse(null);
    }

    public Attempt getAttemptByUserAndQuiz(User user, Quiz quiz) {
        logger.info("Fetching attempt by user {} and quiz {}", user.getUser_id(), quiz.getId());
        return attemptRepo.findAttemptByUserAndQuiz(user,quiz);
    }
    public Attempt createAttempt(Attempt attempt) {
        logger.info("Creating attempt");
        return attemptRepo.save(attempt);
    }

    public void updateAttempt(long id, Attempt attempt) {
        if (attemptRepo.existsById(id)) {
            logger.info("Updating attempt with ID: {}", id);
            attempt.setId(id);
            attemptRepo.save(attempt);
        }
    }

    public void deleteAttempt(long id) {
        logger.info("Deleting attempt with ID: {}", id);
        attemptRepo.deleteById(id);
    }

}
