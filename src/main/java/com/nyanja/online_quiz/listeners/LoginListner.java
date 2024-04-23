package com.nyanja.online_quiz.listeners;

import com.nyanja.online_quiz.model.User;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener("/login")
public class LoginListner implements HttpSessionListener {
    @Override
    public void sessionCreated(HttpSessionEvent listener) {
        HttpSession session = listener.getSession();
        User user = (User)session.getAttribute("user");
        User admin = (User)session.getAttribute("admin");
        if(user!=null){System.out.println("User with email "+ user.getEmail()+" is logging In");}
        if(admin!=null){System.out.println("Admin with email "+ admin.getEmail()+" is logging In");}
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent listener) {
        HttpSession session = listener.getSession();
        User user = (User)session.getAttribute("user");
        User admin = (User)session.getAttribute("admin");
        if(user!=null){System.out.println("User with email "+ user.getEmail()+" is logging out");}
        if(admin!=null){System.out.println("Admin with email "+ admin.getEmail()+" is logging out");}
    }

}
