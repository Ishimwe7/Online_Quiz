package com.nyanja.online_quiz.filters;


import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/register")
public class RegistrationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest)servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;
        String email = servletRequest.getParameter("email");
        String password = servletRequest.getParameter("password");
        String confirmPassword = servletRequest.getParameter("confirmPass");

        if (!email.matches("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$")) {
            req.setAttribute("invalidEmail", "Please provide a valid Email");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/signup");
            dispatcher.forward(req, res);
            return;
        }

//        if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$")) {
//            req.setAttribute("invalidPassword", "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character");
//            RequestDispatcher dispatcher = req.getRequestDispatcher("/signup");
//            dispatcher.forward(req, res);
//            return;
//        }
        if(!password.equals(confirmPassword)){
            req.setAttribute("invalidPassword", "Password Mismatches !");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/signup");
            dispatcher.forward(req, res);
            return;
        }
        filterChain.doFilter(servletRequest,servletResponse);
    }
}
