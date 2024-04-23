<%@ page import="com.nyanja.online_quiz.model.Quiz" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 4/2/2024
  Time: 2:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Question to quiz</title>
    <link href="CSS/dashboardStyles.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <style>
        body{
            margin: 30px auto;
            background: black;
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
            z-index: 333;
        }
        label{
            display: block;
            font-size: x-large;
        }
        #addQuestion{
            margin: auto;
            background: white;
            border-radius: 10px;
            width: 500px;
            height: fit-content;
            position: relative;
            display: grid;
            justify-content: center;
        }
        .row{
            width: 100%;
        }
        .row input{
            width: 100%;
            height: 30px;
            border-radius: 5px;
        }
        button{
            margin: 20px auto;
            font-size: larger;
            display: block;
            border-radius: 5px;
            padding: 5px;
            color: white;
            background: black;
        }
        button:hover{
            cursor: pointer;

        }
        input[type="radio"]{
            width: 30px;
            height: 30px;
            display: inline;
        }
       .row span{
            color: red;
        }
        #qst{
            margin-bottom: 10px;
        }
        #qst input{
            height: 50px;
        }
        .message{
            text-align: center;
            font-size: larger;
        }
        .option{
            display: flex;
            justify-items: center;
        }
    </style>
</head>
<body>
<%
//    int quiz = (int)request.getAttribute("quiz");
//    if(quiz!=null){
//        response.sendRedirect("/noAccess");
//    }
%>
<div id="access">
    <a href="/" id="home" >
        <span class="material-icons-sharp">home</span>
        <h3>Quizify</h3>
    </a>
</div>
<div id="addQuestion">
    <h1 style="text-align: center">Add Question to Quiz</h1>
    <h2 style="color: red">N.B Check in front of an ANSWER option</h2>
    <form action="/addQuestion/<%=request.getAttribute("quizId")%>" id="qst-form" method="post">
        <div class="row" id="qst">
            <label for="question">Question<span>*</span></label>
            <input type="text" id="question" name="question" placeholder="Write Question here" required>
        </div>
        <div class="row">
            <label for="option1">Option 1 <span>*</span></label>
            <p class="option">
                <input type="text" id="option1" required  name="option1" placeholder="Enter answer option 1">
                <input type="radio" id="isAnswer1" name="isAnswer" value="option1" required disabled>
            </p>
        </div>
        <div class="row">
            <label for="option1">Option 2 <span>*</span></label>
           <p class="option">
               <input type="text" id="option2" required name="option2" placeholder="Enter answer option 2">
               <input type="radio" id="isAnswer2" name="isAnswer" value="option2" required disabled>
           </p>
        </div>
        <div class="row">
            <label for="option1">Option 3</label>
            <p class="option">
                <input type="text" id="option3"  name="option3" placeholder="Enter answer option 3">
                <input type="radio" id="isAnswer3" name="isAnswer" value="option3" required disabled>
            </p>
        </div>
        <div class="row">
            <label for="option1">Option 4</label>
            <p class="option">
                <input type="text" id="option4"  name="option4" placeholder="Enter answer option 4">
                <input type="radio" id="isAnswer4" name="isAnswer" value="option4" required disabled>
            </p>
        </div>
        <div class="row">
            <label for="option5">Option 5</label>
            <p class="option">
                <input type="text" id="option5"  name="option5" placeholder="Enter answer option 5">
                <input type="radio" id="isAnswer5" name="isAnswer" value="option5" required disabled>
            </p>
        </div>
        <%
            request.setAttribute("quizId",request.getAttribute("quizId"));
        %>
        <%if(request.getAttribute("success")!=null){%>
        <p class="error message" style="color: green"><%=request.getAttribute("success")%></p>
        <%}%>
        <%if(request.getAttribute("error")!=null){%>
        <p class="error message" style="color: red"><%=request.getAttribute("error")%></p>
        <%}%>
        <button type="submit">Add Question</button>
    </form>
</div>
<script>
    document.getElementById("qst-form").addEventListener('submit', function (){
        if(document.getElementsByName("isAnswer").value=''){
            return alert("Please Select Answer Option !");
        }
    })
    function handleInputValueChange(inputId, radioId) {
        const inputField = document.getElementById(inputId);
        const radioButton = document.getElementById(radioId);

        if (inputField.value.trim() !== '') {
            radioButton.disabled = false; // Enable radio button if input field has a value
        } else {
            radioButton.disabled = true; // Disable radio button if input field is empty
            radioButton.checked = false;
        }
    }

    // Add event listeners to input fields
    document.getElementById('option1').addEventListener('input', function() {
        handleInputValueChange('option1', 'isAnswer1');
    });
    document.getElementById('option2').addEventListener('input', function() {
        handleInputValueChange('option2', 'isAnswer2');
    });
    document.getElementById('option3').addEventListener('input', function() {
        handleInputValueChange('option3', 'isAnswer3');
    });
    document.getElementById('option4').addEventListener('input', function() {
        handleInputValueChange('option4', 'isAnswer4');
    });
    document.getElementById('option5').addEventListener('input', function() {
        handleInputValueChange('option5', 'isAnswer5');
    });
</script>
</body>
</html>
