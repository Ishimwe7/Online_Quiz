<%@ page import="com.nyanja.online_quiz.model.Quiz" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nyanja.online_quiz.model.Attempt" %>
<%@ page import="com.nyanja.online_quiz.model.User" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 4/3/2024
  Time: 4:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Quizzes</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <link href="CSS/quizzesStyle.css" rel="stylesheet">
    <style>
        body{
            background: black;
        }
        #access{
            display: flex;
            color: white;
        }
        .quiz-actions{
            display: flex;
            justify-content: center;
        }
        .quiz-actions a{
            width: fit-content;
            height: 30px;
            text-align: center;
            padding: 3px 5px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
            display: block;
            background: black;
        }
        .quiz-actions a:hover{
            cursor: pointer;
            opacity: 0.7;
        }

        .quiz-title{
            font-size: x-large;
            font-weight: bold;
            color: black;
        }
        .quiz-desc{
            font-size: large;
            width: 100%;
            margin: 0 auto;
            word-break: break-word;
            color: black;
        }
        .limit{
            font-weight: bolder;
            color: black;
        }
        .duration{
            margin: 5px;
            font-size: larger;
            position: absolute;
            right: 20px;
            top: 10px;
            font-style: italic;
            color: black;
        }
        #quizes, #done-quizes{
            width: 80%;
            padding: 30px;
            margin: auto;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }
        .quiz{
            width: 380px;
            height: 150px;
            background: white;
            color: black;
            margin: 20px;
            padding: 10px;
            border-radius: 10px;
            position: relative;
        }
        h1{
            text-align: center;
            color: white;
        }
        .results{
            width: 300px;
            background: black;
            color: white;
            padding: 7px;
            text-align: center;
            border-radius: 10px;
            font-size: larger;
            position: absolute;
            top: 15px;
            left: 30px;
            display: none;
        }
        .closeBtn{
            background: white;
            color: black;
            border-radius: 5px;
        }
        .closeBtn:hover{
            cursor: pointer;
        }
        .viewResults{
            background: black;
            color: white;
            border-radius: 5px;
            font-size: larger;
            padding: 3px;
        }
        .viewResults:hover{
            cursor: pointer;
        }
        p.absent{
            color: white;
            text-align: center;
            font-size: x-large;
        }

        #access a{
            display: flex;
            color: white;
            justify-content: center;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            font-size: x-large;
        }
        #home{
            position: fixed;
            top: 0px;
            left: 20px;
            background: black;
            color: white;
            z-index: 333;
        }
        #user-logout{
            position: fixed;
            top: 0px;
            right: 20px;
            background: black;
            color: white;
            z-index: 333;
        }
        .container {
            text-align: center;
            margin-top: 100px;
            position: fixed;
            right: 20px;
            top: 0;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
            border-radius: 34px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            -webkit-transition: .4s;
            transition: .4s;
            border-radius: 50%;
        }
        p{
            color: white;
        }

        input:checked + .slider {
            background-color: black;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(26px);
            -ms-transform: translateX(26px);
            transform: translateX(26px);
        }
    </style>
</head>
<body>
<%
    User user = (User)session.getAttribute("user");
    if(user==null){
        response.sendRedirect("/login");
    }
    List<Quiz> pendingQuizzes =(List<Quiz>)request.getAttribute("pendingQuizzes");
    List<Quiz> doneQuizzes =(List<Quiz>)request.getAttribute("doneQuizzes");
    List<Attempt> myAttempts =(List<Attempt>)request.getAttribute("myAttempts");
%>
<div id="access" class="white-color">
    <a href="/" id="home" >
        <span class="material-icons-sharp">home</span>
        <h3>Home</h3>
    </a>
    <div class="container">
        <h1 class="white-color" id="theme">White mode</h1>
        <label class="switch">
            <input type="checkbox" id="modeToggle">
            <span class="slider round"></span>
        </label>
    </div>
    <a href="/logout" class="white-color" id="user-logout">
        <h3>Logout</h3>
        <span class="material-icons-sharp">logout</span>
    </a>
</div>
<h1 class="white-color">Available Quizzes</h1>
<%if(!pendingQuizzes.isEmpty()){%>
<div id="quizes">
    <% for (Quiz quiz : pendingQuizzes) { %>
    <div class="quiz" id="<%=quiz.getId()%>">
        <!-- Display quiz details here -->
        <%
            long quizId= quiz.getId();
            request.setAttribute("quizId",quizId);
        %>
        <h3 class="quiz-title"> <%= quiz.getTitle() %> </h3>
        <p class="quiz-desc"> <%= quiz.getDescription() %></p><br>
        <p class="duration">Time limit : <span class="limit"><%=quiz.getDuration()%></span> Minutes</p>
        <div class="quiz-actions">
            <a class="start_quiz actionButton white-color" href="/startQuiz/<%=quiz.getId()%>">Start Quiz</a>
        </div>
    </div>
    <% } %>
</div>
<%} else{%>
<p class="absent white-color">No pending quizzes available</p>
<%}%>
<h1>Done Quizzes</h1>
<%if(!doneQuizzes.isEmpty()){%>
<div id="done-quizes">
    <% for (Quiz quiz : doneQuizzes) { %>
    <div class="quiz" id="<%=quiz.getId()%>">
        <!-- Display quiz details here -->
        <%
            long quizId= quiz.getId();
            request.setAttribute("quizId",quizId);
        %>
        <h3 class="quiz-title"> <%= quiz.getTitle() %> </h3>
        <p class="quiz-desc"> <%= quiz.getDescription() %></p><br>
<%--        <p class="duration">Time limit : <span class="limit"><%=quiz.getDuration()%></span> Minutes</p>--%>
        <div class="quiz-actions">
<%--            <a id="view-results" class="actionButton">View Attempt Results</a>--%>
            <button class="viewResults white-color" id="viewRes<%=quiz.getId()%>" value="<%=quiz.getId()%>">View Attempt Results</button>
        </div>
        <script>
            document.getElementById("viewRes"+<%=quiz.getId()%>).addEventListener('click',()=>{
                document.getElementById("quizRes+<%=quiz.getId()%>").style.display="block";
            })
        </script>
        <% for (Attempt attempt : myAttempts) {
        if(attempt.getQuiz()==quiz){%>
        <div class="results"  id="quizRes+<%=quiz.getId()%>">
            <!-- Display quiz details here -->
            <p class="user">You <%= attempt.getUser().getUsername() %>,</p>
            <p class="marks">Obtained : <span class=""><strong><%=attempt.getMarksObtained()%></strong></span> % in <%=attempt.getQuiz().getTitle()%></p>
            <button class="closeBtn" id="closeRes<%=quiz.getId()%>" >Close</button>
            <script>
                document.getElementById("closeRes"+<%=quiz.getId()%>).addEventListener('click',()=>{
                    document.getElementById("quizRes+<%=quiz.getId()%>").style.display="none";
                })
            </script>
        </div>
        <%}%>
        <% } %>
    </div>
    <% } %>
</div>
<%} else{%>
<p class="absent white-color">You haven't done any quiz yet !</p>
<%}%>
</body>
<script>
    const modeToggle = document.getElementById('modeToggle');

    modeToggle.addEventListener('change', () => {
        var allElements = document.querySelectorAll('*');

// Loop through each element
        allElements.forEach(function(element) {
            // Get the computed styles of the element
            var styles = window.getComputedStyle(element);

            // Check color and background color
            var color = styles.color;
            var bgColor = styles.backgroundColor;

            // Check if color is white
            if (color === 'rgb(255, 255, 255)' || color === '#ffffff') {
                element.style.color = 'black'; // Change white text to black
            } else if (color === 'rgb(0, 0, 0)' || color === '#000000') {
                element.style.color = 'white'; // Change black text to white
            }

            // Check if background color is white
            if (bgColor === 'rgb(255, 255, 255)' || bgColor === '#ffffff') {
                element.style.backgroundColor = 'black'; // Change white background to black
            } else if (bgColor === 'rgb(0, 0, 0)' || bgColor === '#000000') {
                element.style.backgroundColor = 'white'; // Change black background to white
            }
        });
        if (modeToggle.checked) {
           document.getElementById("theme").textContent="Dark Mode"
            document.getElementById("home").style.color="black";
            document.getElementById("user-logout").style.color="black";
        } else {
            document.getElementById("user-logout").style.color="white";
            document.getElementById("home").style.color="white";
            document.getElementById("theme").textContent="White Mode"
        }
    });
</script>
</html>