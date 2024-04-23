package com.nyanja.online_quiz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {

    @RequestMapping("/myError")
    public String errorHandling() {
        // Handle the error and return the name of the error page
        return "error"; // Return the name of your custom error page (e.g., error.html)
    }
}