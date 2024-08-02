package com.nyanja.online_quiz.controller;

import com.nyanja.online_quiz.model.*;
import com.nyanja.online_quiz.services.*;
import jakarta.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController  extends  HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
    @GetMapping("/online-quiz-app")
    public String home() {
        logger.info("Going to home page");
        return "index";
    }


    @Autowired
    public UserService userService;

    @GetMapping("/login")
    public String login(Model model) {
        logger.info("Accessing login page");
        model.addAttribute("user", new User());
        return "login";
    }

    @GetMapping("/logout")
    public String logout(Model model, HttpSession session) {
        logger.info("User is logging out");
        session.invalidate();
        return "login";
    }

    @GetMapping("/**")
    public String handleUnknownRequest() {
        logger.info("User is trying to access unavailable page");
        return "noPage";
    }

    @PostMapping("/checkUser")
    public String checkUser(User user, Quiz quiz,@RequestParam(required = false) String remember, Model model,HttpServletResponse response, HttpSession session) {
       // System.out.println("Hello "+user.getPassword());
        System.out.println("User with email "+user.getEmail() +" is logging In");
        logger.info("Trying to check user info for authentication");
        try {
            model.addAttribute("user", user);
            model.addAttribute("quiz", quiz);
            User loggedUser = userService.emailExists(user);
            System.out.println("Hello "+user.getPassword());
            if (loggedUser != null) {
                String hashedPasswordFromDB = loggedUser.getPassword();
                BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
                System.out.println("Hello "+user.getPassword());
                System.out.println("Hello "+hashedPasswordFromDB);
                if (encoder.matches(user.getPassword(), hashedPasswordFromDB)) {
                    System.out.println("Hello "+loggedUser.getPassword());
                    if (loggedUser.isAdmin()) {
                        List<Quiz> myQuizzes = quizService.getQuizzesByOwner(loggedUser);
                        model.addAttribute("quizzes", myQuizzes);
                        session.setAttribute("admin", loggedUser);
                        if (remember != null) {
                            Cookie cookie = new Cookie("adminEmailCookie", loggedUser.getEmail().trim());
                            Cookie cookie2 = new Cookie("adminPasswordCookie", loggedUser.getPassword().trim());
                            cookie.setMaxAge(3600);
                            cookie2.setMaxAge(3600);
                            response.addCookie(cookie);
                            response.addCookie(cookie2);
                        }
                        return "adminDashboard";
                    } else {
                        session.setAttribute("user", loggedUser);
                        if (remember != null) {
                            Cookie cookie = new Cookie("userEmailCookie", loggedUser.getEmail().trim());
                            Cookie cookie2 = new Cookie("userPasswordCookie", loggedUser.getPassword().trim());
                            cookie.setMaxAge(3600);
                            cookie2.setMaxAge(3600);
                            response.addCookie(cookie);
                            response.addCookie(cookie2);
                        }
                        List<Quiz> allQuizzes = quizService.getAllQuizzes();
                        List<Quiz> doneQuizzes = new ArrayList<>();
                        List<Quiz> pendingQuizzes = new ArrayList<>();
                        List<Attempt> myAttempts = new ArrayList<>();
                        for (Quiz myQuiz : allQuizzes) {
                            Attempt attempt = attemptService.getAttemptByUserAndQuiz(loggedUser, myQuiz);
                            List<Question> questions = questionService.getAllQuestionsByQuiz(myQuiz);
                            if (!questions.isEmpty()) {
                                if (attempt != null) {
                                    doneQuizzes.add(myQuiz);
                                    myAttempts.add(attempt);
                                } else {
                                    pendingQuizzes.add(myQuiz);
                                }
                            }
                        }
                        model.addAttribute("doneQuizzes", doneQuizzes);
                        model.addAttribute("pendingQuizzes", pendingQuizzes);
                        model.addAttribute("myAttempts", myAttempts);
                        System.out.println(doneQuizzes);
                        System.out.println(pendingQuizzes);
                        return "quizzes";
                    }
                }
                else {
                    model.addAttribute("invalidLogin", "Invalid Login ! Please enter valid credentials");
                    return "login";
                }
            } else {
                model.addAttribute("invalidLogin", "Invalid Login ! Please enter valid credentials");
                return "login";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Internal Server Error !");
            return "login";
        }
    }

    @GetMapping("/adminPanel")
    public String checkadminCookies(User user, Quiz quiz, Model model, HttpSession session, HttpServletRequest request) {
        logger.info("Checking admin page access cookies");
        try {
            model.addAttribute("user", user);
            model.addAttribute("quiz", quiz);
            Cookie[] cookies = request.getCookies();
            if(cookies!=null) {
                String email = "";
                String password = "";
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equalsIgnoreCase("adminEmailCookie")) {
                        email = cookie.getValue();
                    }
                    if (cookie.getName().equalsIgnoreCase("adminPasswordCookie")) {
                        password = cookie.getValue();
                    }
                    User loggedUser = userService.getUser(email, password);
                    System.out.println(email + " "+password);
                    if (loggedUser != null) {
                        System.out.println(cookie.getName() + " "+ cookie.getValue());
                        if (loggedUser.isAdmin()) {
                            List<Quiz> myQuizzes = quizService.getQuizzesByOwner(loggedUser);
                            model.addAttribute("quizzes", myQuizzes);
                            session.setAttribute("admin", loggedUser);
                            return "adminDashboard";
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Internal Server Error !");
            return "login";
        }
        return "index";
    }

    @GetMapping("/Quizzes")
    public String checkUserCookies(User user, Quiz quiz, Model model, HttpSession session, HttpServletRequest request) {
        logger.info("Checking quizzes page access cookies");
        try {
            model.addAttribute("user", user);
            model.addAttribute("quiz", quiz);
            Cookie[] cookies = request.getCookies();
            if(cookies!=null) {
                String email = "";
                String password = "";
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equalsIgnoreCase("userEmailCookie")) {
                        email = cookie.getValue();
                    }
                    if (cookie.getName().equalsIgnoreCase("userPasswordCookie")) {
                        password = cookie.getValue();
                    }
                    User loggedUser = userService.getUser(email, password);
                    System.out.println(email + " "+password);
                    if (loggedUser != null) {
                        List<Quiz> allQuizzes = quizService.getAllQuizzes();
                        List<Quiz> doneQuizzes = new ArrayList<>();
                        List<Quiz> pendingQuizzes = new ArrayList<>();
                        List<Attempt> myAttempts = new ArrayList<>();
                        for (Quiz myQuiz : allQuizzes) {
                            Attempt attempt = attemptService.getAttemptByUserAndQuiz(loggedUser, myQuiz);
                            List<Question> questions = questionService.getAllQuestionsByQuiz(myQuiz);
                            if (!questions.isEmpty()) {
                                if (attempt != null) {
                                    doneQuizzes.add(myQuiz);
                                    myAttempts.add(attempt);
                                } else {
                                    pendingQuizzes.add(myQuiz);
                                }
                            }
                        }
                        // model.addAttribute("quizzes",allQuizzes);
                        model.addAttribute("doneQuizzes", doneQuizzes);
                        model.addAttribute("pendingQuizzes", pendingQuizzes);
                        model.addAttribute("myAttempts", myAttempts);
                        // model.addAttribute("attempts",allAttempts);
                        session.setAttribute("user", loggedUser);
                        System.out.println(doneQuizzes);
                        System.out.println(pendingQuizzes);
                        return "quizzes";
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Internal Server Error !");
            return "login";
        }
        return "index";
    }

    @GetMapping("/userHome")
    public String backHome(Model model, HttpSession session) {
        logger.info("Going back to home page");
        try {
            User loggedUser = (User) session.getAttribute("user");
            if (loggedUser != null) {
                List<Quiz> allQuizzes = quizService.getAllQuizzes();
                List<Quiz> doneQuizzes = new ArrayList<>();
                List<Quiz> pendingQuizzes = new ArrayList<>();
                List<Attempt> allAttempts = attemptService.getAllAttempts();
                List<Attempt> myAttempts = new ArrayList<>();
                for (Quiz myQuiz : allQuizzes) {
                    Attempt attempt = attemptService.getAttemptByUserAndQuiz(loggedUser, myQuiz);
                    List<Question> questions = questionService.getAllQuestionsByQuiz(myQuiz);
                    if (!questions.isEmpty()) {
                        if (attempt != null) {
                            doneQuizzes.add(myQuiz);
                            myAttempts.add(attempt);
                        } else {
                            pendingQuizzes.add(myQuiz);
                        }
                    }
                    // model.addAttribute("quizzes",allQuizzes);
                    model.addAttribute("doneQuizzes", doneQuizzes);
                    model.addAttribute("pendingQuizzes", pendingQuizzes);
                    model.addAttribute("myAttempts", myAttempts);
                    // model.addAttribute("attempts",allAttempts);
                    session.setAttribute("user", loggedUser);
                    System.out.println(doneQuizzes);
                    System.out.println(pendingQuizzes);
                }
                return "quizzes";
            } else {
                model.addAttribute("invalidLogin", "Invalid Login ! Please enter valid credentials");
                return "login";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Internal Server Error !");
            return "login";
        }
    }


    @GetMapping("/signup")
    public String signup(Model model) {
        logger.info("Going to registration page");
        model.addAttribute("user", new User());
        model.addAttribute("confirmPass", new String());
        //model.addAttribute("isAdmin", new String());
        return "signup";
    }
    @PostMapping("/signup")
    public String sign(Model model) {
        logger.info("Going to registration page");
        model.addAttribute("user", new User());
        model.addAttribute("confirmPass", new String());
        //model.addAttribute("isAdmin", new String());
        return "signup";
    }

    @PostMapping("/register")
    public String saveUser(User user, String confirmPass, boolean isAdmin, Model model) {
        logger.info("Submitting user's info for registration");
        try {
            if (!user.getPassword().equals(confirmPass)) {
                model.addAttribute("passMis", "Password Mismatches !");
                return "signup";
            }
            if (userService.emailExists(user) != null) {
                model.addAttribute("emailExists", "Email already Registered !");
                return "signup";
            }
            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            String hashedPassword = encoder.encode(user.getPassword());
            user.setPassword(hashedPassword);
            if (isAdmin) {
                user.setAdmin(true);
            } else {
                user.setAdmin(false);
            }
            if (userService.createUser(user) != null) {
                model.addAttribute("success", "Registration done Successfully!");
                return "signup"; // Redirect to a success page
            } else {
                model.addAttribute("error", "An expected error occurred!");
                return "signup";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Internal Server error!");
            return "signup";
        }
    }

    @Autowired
    public QuizService quizService;

    @GetMapping("/deleteQuiz/{quizId}")
    public String deleteQuiz(@PathVariable long quizId, Model model, HttpSession session) {
        logger.info("Going to delete a quiz");
        try {
            quizService.deleteQuiz(quizId);
            User admin = (User) session.getAttribute("admin");
            List<Quiz> allQuizzes = quizService.getQuizzesByOwner(admin);
            model.addAttribute("quizzes", allQuizzes);
            return "adminDashboard";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @PostMapping("/createQuiz")
    public String createQuiz(Quiz quiz, Model model, HttpSession session) {
        logger.info("You creating new quiz");
        try {
            User admin = (User) session.getAttribute("admin");
            quiz.setOwner(admin);
            if (quizService.createQuiz(quiz) != null) {
                List<Quiz> allQuizzes = quizService.getQuizzesByOwner(admin);
                model.addAttribute("quizzes", allQuizzes);
                return "adminDashboard";
            } else {
                return "redirect:error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "noAccess";
        }
    }

    @PostMapping("/editQuiz/{quizId}")
    public String editQuiz(@PathVariable long quizId, Model model,@RequestParam String title,@RequestParam String description,@RequestParam String duration,HttpSession session) {
        logger.info("Updating existing quiz");
        try {
            Quiz quiz = (Quiz)quizService.getQuizById(quizId);
            User owner = (User)session.getAttribute("admin");
            quiz.setTitle(title);
            quiz.setDescription(description);
            quiz.setOwner(owner);
            quiz.setDuration(Double.parseDouble(duration));
            if (quizService.updateQuiz(quizId,quiz) != null) {
                List<Quiz> allQuizzes = quizService.getQuizzesByOwner(owner);
                model.addAttribute("quizzes", allQuizzes);
                model.addAttribute("success"," Quiz Edited Successfully !!");
                return "adminDashboard";
            } else {
                return "redirect:error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @Autowired
    public QuestionService questionService;
    @Autowired
    public AttemptService attemptService;
    @Autowired
    public OptionService optionService;

    @GetMapping("/createQuestion/{quizId}")
    public String createQuestion(@PathVariable long quizId, HttpSession session, Model model) {
        logger.info("Going to a page of adding a question to a quiz");
        Quiz quiz = quizService.getQuizById(quizId);
        model.addAttribute("quizId", quizId);
        model.addAttribute("quiz",quiz);
        model.addAttribute("question", new String());
        model.addAttribute("option1", new String());
        model.addAttribute("option2", new String());
        model.addAttribute("option3", new String());
        model.addAttribute("option4", new String());
        model.addAttribute("option5", new String());
        model.addAttribute("success", new String());
        model.addAttribute("error", new String());
        String successMessage = (String) session.getAttribute("success");
        String errorMessage = (String) session.getAttribute("error");
        session.removeAttribute("success");
        session.removeAttribute("error");
        model.addAttribute("success", successMessage);
        model.addAttribute("error", errorMessage);
        return "createQuestion";
    }

    @PostMapping("/addQuestion/{quizId}")
    public String addQuestion(@PathVariable long quizId, @RequestParam String isAnswer, @RequestParam String question, @RequestParam String option1, @RequestParam String option2, @RequestParam(required = false) String option3, @RequestParam(required = false) String option4, @RequestParam(required = false) String option5, HttpSession session, Model model) {
       logger.info("Submitting new question to be saved in DB");
        try {
            if (isAnswer.isEmpty()) {
                session.setAttribute("error", "Please Select Answer Option");
                return "redirect:/createQuestion/" + quizId;
            }
            System.out.println(question);
            Quiz quiz = quizService.getQuizById(quizId);
            Question newQuestion = new Question();
            newQuestion.setQuestion(question);
            newQuestion.setQuiz(quiz);
            System.out.println(newQuestion);
            Question savedQuestion = questionService.createQuestion(newQuestion);
            if (savedQuestion != null) {
                if (!option1.isEmpty()) {
                    Option option = new Option();
                    option.setOption(option1);
                    if (isAnswer.equals("option1")) {
                        option.setAnswer(true);
                    } else {
                        option.setAnswer(false);
                    }
                    option.setQuestion(savedQuestion);
                    if (optionService.createOption(option) == null) {
                        session.setAttribute("error", "Failed to add option: " + option.getOption());
                        return "redirect:/createQuestion/" + quizId;
                    }
                }
                if (!option2.isEmpty()) {
                    Option option = new Option();
                    option.setOption(option2);
                    option.setQuestion(savedQuestion);
                    if (isAnswer.equals("option2")) {
                        option.setAnswer(true);
                    } else {
                        option.setAnswer(false);
                    }
                    if (optionService.createOption(option) == null) {
                        session.setAttribute("error", "Failed to add option: " + option.getOption());
                        return "redirect:/createQuestion/" + quizId;
                    }
                }
                if (!option3.isEmpty()) {
                    Option option = new Option();
                    option.setOption(option3);
                    option.setQuestion(savedQuestion);
                    if (isAnswer.equals("option3")) {
                        option.setAnswer(true);
                    } else {
                        option.setAnswer(false);
                    }
                    if (optionService.createOption(option) == null) {
                        session.setAttribute("error", "Failed to add option: " + option.getOption());
                        return "redirect:/createQuestion/" + quizId;
                    }
                }
                if (!option4.isEmpty()) {
                    Option option = new Option();
                    option.setOption(option4);
                    option.setQuestion(savedQuestion);
                    if (isAnswer.equals("option4")) {
                        option.setAnswer(true);
                    } else {
                        option.setAnswer(false);
                    }
                    if (optionService.createOption(option) == null) {
                        session.setAttribute("error", "Failed to add option: " + option.getOption());
                        return "redirect:/createQuestion/" + quizId;
                    }
                }
                if (!option5.isEmpty()) {
                    Option option = new Option();
                    option.setOption(option5);
                    option.setQuestion(savedQuestion);
                    if (isAnswer.equals("option5")) {
                        option.setAnswer(true);
                    } else {
                        option.setAnswer(false);
                    }
                    if (optionService.createOption(option) == null) {
                        session.setAttribute("error", "Failed to add option: " + option.getOption());
                        return "redirect:/createQuestion/" + quizId;
                    }
                }
                session.setAttribute("success", "Question Added Successfully ");
            } else {
                session.setAttribute("error", "Failed to add Question");
            }
            return "redirect:/createQuestion/" + quizId;
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Internal Server Error ");
            return "redirect:/createQuestion/" + quizId;
        }
    }

    @GetMapping("/startQuiz/{quizId}")
    public String startQuiz(@PathVariable long quizId, HttpSession session, Model model) {
        logger.info("Starting attempt for quiz with ID"+quizId);
        Quiz quiz = quizService.getQuizById(quizId);
        List<Question> questions = questionService.getAllQuestionsByQuiz(quiz);
        //    Option selectedOpt = optionService.getOptionById(selectedOption);
//        List<Option> selectedOptions = new ArrayList<>();
//        if(selectedOpt!=null){
//            selectedOptions.add(selectedOpt);
//        }
//        int indexOfOption = selectedOptions.indexOf(selectedOpt);
        List<Option> selectedOptions = new ArrayList<>();
        for (int i = 0; i < questions.size(); i++) {
            selectedOptions.add(null); // Initialize with null for each question
        }
        session.setAttribute("quizDuration",quiz.getDuration());
        session.setAttribute("selectedOptions", selectedOptions);
        session.setAttribute("questions", questions);
        session.setAttribute("currentQuestionIndex", 0);
        session.setAttribute("question", questions.get(0));
        session.setAttribute("quiz", quiz);
        Question currentQuestion = questions.get(0);
        List<Option> options = optionService.getAllOptionsByQuestion(currentQuestion);
        model.addAttribute("question", currentQuestion);
        model.addAttribute("options", options);
        // model.addAttribute("selectedOptionId", new String());
        session.setAttribute("options", options);
        System.out.println(questions);
        session.setAttribute("quizStartTime", System.currentTimeMillis());
        return "question";
    }

//    @GetMapping("/question")
//    public String showQuestion(HttpSession session, Model model) {
//        List<Question> questions = (List<Question>) session.getAttribute("questions");
//        int currentQuestionIndex = (int) session.getAttribute("currentQuestionIndex");
//        Question currentQuestion = questions.get(currentQuestionIndex);
//        model.addAttribute("question", currentQuestion);
//        model.addAttribute("options", currentQuestion);
//        // model.addAttribute("selectedOptionId",new Long());
//        List<Option> options = optionService.getAllOptionsByQuestion(currentQuestion);
//        session.setAttribute("question", currentQuestion);
//        session.setAttribute("options", options);
//        boolean isLastQuestion = currentQuestionIndex == questions.size() - 1;
//        model.addAttribute("isLastQuestion", isLastQuestion);
//
//        return "redirect:question";
//    }

    @GetMapping("/quiz/next")
    public String nextQuestion(HttpSession session, @RequestParam(value = "selectedOptionId", required = false) String selectedOptionId, Model model) {
       logger.info("Attempting next quiz question");
        List<Question> questions = (List<Question>) session.getAttribute("questions");
        int currentQuestionIndex = (int) session.getAttribute("currentQuestionIndex");
//        Question question = (Question) session.getAttribute("currentQuestion");
//        question.setSelectedOption(se);
        List<Option> selectedOptions = (List<Option>) session.getAttribute("selectedOptions");
        if (selectedOptionId != null) {
            long optionId = Long.parseLong(selectedOptionId);
            selectedOptions.set(currentQuestionIndex, optionService.getOptionById(optionId));
        } else {
            selectedOptions.set(currentQuestionIndex, null);
        }
        session.setAttribute("selectedOptions", selectedOptions);
        currentQuestionIndex++;
        Question currentQuestion = questions.get(currentQuestionIndex);
        session.setAttribute("currentQuestionIndex", currentQuestionIndex);
        session.setAttribute("question", currentQuestion);
        List<Option> options = optionService.getAllOptionsByQuestion(currentQuestion);
        session.setAttribute("options", options);
        model.addAttribute("selectedOptionId", new String());
        return "question";
    }

//    @GetMapping("/quiz/previous")
//    public String previousQuestion(HttpSession session, Model model) {
//        List<Question> questions = (List<Question>) session.getAttribute("questions");
//        int currentQuestionIndex = (int) session.getAttribute("currentQuestionIndex");
//        List<Option> selectedOptions = (List<Option>) session.getAttribute("selectedOptions");
//        selectedOptions.set(currentQuestionIndex, null); // Clear selected option for the previous question
//        session.setAttribute("selectedOptions", selectedOptions);
//        currentQuestionIndex--;
//        Question currentQuestion = questions.get(currentQuestionIndex);
//        session.setAttribute("currentQuestionIndex", currentQuestionIndex);
//        session.setAttribute("question", currentQuestion);
//        model.addAttribute("selectedOptionId", new String());
//        List<Option> options = optionService.getAllOptionsByQuestion(currentQuestion);
//        session.setAttribute("options", options);
//        return "question";
//    }

    @GetMapping("/quiz/finish")
    public String finishQuiz(HttpSession session, @RequestParam(value = "selectedOptionId", required = false) String selectedOptionId) {
      logger.info("Finalizing quiz");
        try{
          List<Question> questions = (List<Question>) session.getAttribute("questions");
          int currentQuestionIndex = (int) session.getAttribute("currentQuestionIndex");
          List<Option> selectedOptions = (List<Option>) session.getAttribute("selectedOptions");
          if (selectedOptionId != null) {
              long optionId = Long.parseLong(selectedOptionId);
              selectedOptions.set(currentQuestionIndex, optionService.getOptionById(optionId));
          } else {
              selectedOptions.set(currentQuestionIndex, null);
          }
          int marks = calculateMarks(selectedOptions);
          int outOff = questions.size();
          marks = (marks * 100) / outOff;
          session.setAttribute("marks", marks);
          session.setAttribute("outOff", outOff);
          session.setAttribute("selectedOptions", selectedOptions);
          Attempt attempt = new Attempt();
          attempt.setQuiz((Quiz) session.getAttribute("quiz"));
          attempt.setUser((User) session.getAttribute("user"));
          attempt.setMarksObtained(marks);
          attemptService.createAttempt(attempt);
          // session.removeAttribute("questions");
          //session.removeAttribute("currentQuestionIndex");
          return "finish";
      } catch (Exception ex){
          ex.printStackTrace();
          return "noAccess";
      }

    }

    private int calculateMarks(List<Option> selectedOptions) {
        logger.info("Calculating quiz attempt marks");
        int marks = 0;
        for (Option option : selectedOptions) {
            if (option != null && option.getAnswer()) {
                marks++;
            }
        }
        return marks;
    }

    private void updateQuizTimer(HttpSession session) {
        long quizStartTime = (long) session.getAttribute("quizStartTime");
        long quizDuration = (long) session.getAttribute("quizDuration");
        long elapsedTime = System.currentTimeMillis() - quizStartTime;
        long remainingTime = Math.max(0, quizDuration - elapsedTime);

        // Update remaining time in session
        session.setAttribute("remainingTime", remainingTime);
    }
}
