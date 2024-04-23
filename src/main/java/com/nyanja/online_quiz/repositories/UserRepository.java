package com.nyanja.online_quiz.repositories;

import com.nyanja.online_quiz.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    User findUserByEmailAndPassword(String email, String password);
}
