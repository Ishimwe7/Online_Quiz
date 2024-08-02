package com.nyanja.online_quiz.services;

import com.nyanja.online_quiz.model.User;
import com.nyanja.online_quiz.repositories.UserRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    //private static final Logger logger = LoggerFactory.getLogger(AttemptService.class);
    private static final Logger logger = (Logger) LogManager.getLogger(UserService.class);
    public List<User> getAllUsers() {
        logger.info("Fetching all Users");
        return userRepository.findAll();
    }

    public User getUserById(long id) {
        logger.info("Getting User by id");
        return userRepository.findById(id).orElse(null);
    }

    public User getUser(String email, String password) {
        logger.info("Getting user by email and password");
        return userRepository.findUserByEmailAndPassword(email,password);
    }
    public User createUser(User user) {
        logger.info("Creating user");
        return userRepository.save(user);
    }

    public User emailExists(User user){
        logger.info("Checking if email exits");
        return userRepository.findByEmail(user.getEmail());
    }
    public void updateUser(long id, User user) {
        if (userRepository.existsById(id)) {
            logger.info("Updating user");
            user.setUser_id(id);
            userRepository.save(user);
        }
    }

    public void deleteUser(long id) {
        logger.info("Deleting user");
        userRepository.deleteById(id);
    }

}
