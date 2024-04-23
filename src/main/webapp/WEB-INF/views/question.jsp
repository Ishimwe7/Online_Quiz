<%@ page import="com.nyanja.online_quiz.model.Option" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nyanja.online_quiz.model.Question" %>
<%@ page import="com.nyanja.online_quiz.services.QuestionService" %>
<%@ page import="com.nyanja.online_quiz.model.User" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 4/3/2024
  Time: 5:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Question</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <style>
        /* Add CSS styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: black;
            padding: 20px;
        }
        h1, h2 {
            color: #333;
            text-align: center;
        }
        form {
            margin: 20px auto;
            display: grid;
            justify-content: center;
        }
        input[type="radio"] {
            margin-right: 10px;
        }
        input[type="submit"] {
            margin-top: 50px;
        }
        .option{
            display: flex;
            gap: 7px;
            align-items: center;
            margin: 0 100px;
        }
        .option input{
            width: 25px;
            height: 25px;
        }
        .option label{
            font-size: larger;
        }
        #question-container{
            display: grid;
            justify-content: center;
            width: 500px;
            border-radius: 10px;
            background: white;
            margin: 30px auto;
            position: relative;
        }
        #buttons button{
            font-size: x-large;
            background: black;
            color: white;
            border-radius: 8px;
            width: 150px;
        }
        #buttons button:hover{
            cursor: pointer;
        }
        #buttons{
            display: flex;
            gap: 300px;
            justify-content: space-evenly;
            margin: 80px 20px 20px 20px;
        }
        #buttons a{
            text-decoration: none;
            color: black;
        }
        button:disabled{
            cursor: not-allowed;
        }
        #countdown{
            color: white;
            font-size: x-large;
            text-align: right;
        }
    </style>
    <script>
        // Add JavaScript functions here if needed
        function validateForm() {
            // Add client-side validation logic here if needed
            return true; // Return true to submit the form, or false to prevent submission
        }
        function updateFormAction(action) {
            document.getElementById('questionForm').action = action;
        }
    </script>
</head>
<body>
<div>
    <h1 id="countdown"></h1>
</div>
<div id="question-container">
    <h1>Quizify quiz Question <span class="material-icons-sharp">quiz</span></h1>

    <%
        //QuestionService questionService;
        // long questionId = Integer.parseInt(request.getParameter("question"));
        // Question question = questionService.getQuestionById(questionId);
        Question myQuestion = (Question) session.getAttribute("question");
        List<Option> myoptions = (List<Option>)session.getAttribute("options");
        User user = (User)session.getAttribute("user");
        if(myQuestion==null || myoptions == null || user==null){
            response.sendRedirect("/noAccess");
        }
       List<Question> qts = (List<Question>) session.getAttribute("questions");
       int quizcount = (int)session.getAttribute("currentQuestionIndex");
        quizcount=quizcount+1;
    %>
    <!-- Display the question -->
    <h2><%=myQuestion.getQuestion()%> (Question <%=quizcount%> of <%=qts.size()%>)</h2>
    <!-- Display the options -->
    <form action="" method="get" id="questionForm" onsubmit="return validateForm()">
        <%
            // Question question = (Question) session.getAttribute("question");
            List<Option> options = (List<Option>)session.getAttribute("options");
            // List<Option> options = question.getOptions();
            for (Option option : options) {
        %>
        <div class="option">
            <input type="radio" name="selectedOptionId" required id="<%=option.getId()%>" value="<%=option.getId()%>">
            <label><%=option.getOption()%></label><br>
        </div>
        <%
        }
    %><!-- Add a submit button to submit the answer -->
        <%--    <input type="submit" value="Submit Answer">--%>
        <div id="buttons">
<%--            <%if((int)session.getAttribute("currentQuestionIndex")>0){%>--%>
<%--            <button type="button" id="previousBtn" class="btn" onclick="updateFormAction('/quiz/previous'); document.getElementById('quizForm').submit();">Previous</button>--%>
<%--            <%}%>--%>
<%--            <%if((int)session.getAttribute("currentQuestionIndex")==0){%>--%>
<%--            <button disabled type="submit" class="btn">Previous</button>--%>
<%--            <%}%>--%>
            <%
                List<Question> questions = (List<Question>) session.getAttribute("questions");
                if((int)session.getAttribute("currentQuestionIndex")<questions.size()-1){
            %>
            <button  type="submit" id="nextBtn" class="btn" onclick="updateFormAction('/quiz/next'); document.getElementById('quizForm').submit();">Next
                <span class="material-icons-sharp">skip_next</span>
            </button>
            <%}%>
            <%
                if((int)session.getAttribute("currentQuestionIndex")==questions.size()-1){
            %>
            <button  type="submit" id="finishBtn" class="btn" onclick="updateFormAction('/quiz/finish'); document.getElementById('quizForm').submit();">Finish</button>
            <%}%>
        </div>
    </form>

</div>

<script>

    // Add event listener for beforeunload event to prevent leaving the page
    // window.addEventListener("beforeunload", function (e) {
    //     var confirmationMessage = "Are you sure you want to leave? Your attempt will be ended.";
    //     window.leavingPage = true;
    //     (e || window.event).returnValue = confirmationMessage;
    //     return confirmationMessage;
    // });
    //
    // // Function to remove event listener when the quiz is finished
    // function removeBeforeUnloadListener() {
    //     window.removeEventListener("beforeunload", function (e) {
    //         window.removeEventListener("beforeunload", beforeUnloadHandler);
    //         finishQuiz();
    //     });
    // }

    var quizDurationMinutes = <%= session.getAttribute("quizDuration") %>;
    var quizDurationSeconds = quizDurationMinutes * 60;
    var quizStartTime = <%= session.getAttribute("quizStartTime") %>;
    var elapsedTime = Math.floor((new Date().getTime() - quizStartTime) / 1000);
    var remainingTime = Math.max(0, quizDurationSeconds - elapsedTime);
    var countdownElement = document.getElementById('countdown');
    countdownElement.innerText = 'Time remaining: ' + formatTime(remainingTime);
    var timer = setInterval(function() {
        if (remainingTime <= 0) {
            clearInterval(timer); // Stop the timer when time is up
            finishQuiz();
        } else {
            countdownElement.innerText = 'Time remaining: ' + formatTime(remainingTime);
            remainingTime--;
        }
    }, 1000);
    function formatTime(timeInSeconds) {
        var hours = Math.floor(timeInSeconds / 3600);
        var minutes = Math.floor((timeInSeconds % 3600) / 60);
        var seconds = timeInSeconds % 60;
        return hours + 'h ' + minutes + 'm ' + seconds + 's';
    }

    function finishQuiz() {
        // Redirect to the finish method or perform any other action
        window.location.href = '/quiz/finish';
    }
    
</script>
</body>
</html>
