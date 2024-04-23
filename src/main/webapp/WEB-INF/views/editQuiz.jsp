<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 4/6/2024
  Time: 1:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <%--    <link rel="stylesheet" href="CSS/dashboardStyles.css">--%>
    <script defer src="../JavaScript/adminControl.js"></script>
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        aside{
            background: black;
            color: white;
            height: 100vh;
            width: 20%;
            padding: 20px;
            position: fixed;

        }
        .container{
            display: flex;
            /*justify-content: center;*/
            gap: 10%;
            position: relative;
        }
        .sidebar{
            margin-top: 80px;
        }
        .sidebar a{
            color: white;
            text-decoration: none;
            margin-top: 30px;
            display: flex;
            font-size: 25px;
        }
        .sidebar a:last-child{
            position: absolute;
            bottom: 20px;
        }
        .close{
            display: none;
        }
        main{
            display: grid;
            justify-content: center;
            margin: 50px 20%;
            position: relative;
            width: 70%;
        }

        main h1{
            text-align: center;
        }
        .row{
            margin-top: 20px;
        }
        label{
            display: block;
            font-size: x-large;
        }
        input,textarea{
            width: 400px;
            height: 35px;
            font-size: larger;
            border: none;
            border-bottom: 1px solid black;
        }
        button{
            margin: 20px auto;
            font-size: x-large;
            position: relative;
            text-align: center;
        }
        button:hover{
            cursor: pointer;
        }
        .quiz-actions{
            display: flex;
            justify-content: center;
        }
        .quiz-actions a{
            width: fit-content;
            height: 30px;
            text-align: center;
            padding: 5px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
        }
        .quiz-actions a:hover{
            cursor: pointer;
            opacity: 0.7;
        }
        .actionButton a{
            font-size: small;
        }
        #deleteQuiz{
            background: red;
            color: black;
        }
        #editQuiz{
            background: yellow;
            color: black;
        }
        #add_question{
            background: green;
        }
        #quiz_questions{
            background: dodgerblue;
        }
        .quiz-title{
            font-size: x-large;
            font-weight: bold;
        }
        .quiz-desc{
            font-size: large;
            width: 100%;
            margin: auto;
            word-break: break-word;
        }
        .limit{
            font-weight: bolder;
        }
        .duration{
            margin: 5px;
            font-size: larger;
            position: absolute;
            right: 20px;
            top: 20px;
        }
        #quizes{
            width: 100%;
            padding: 30px;
        }
        .quiz{
            width: 100%;
            background: #9bb4e0;
            margin: auto;
            padding: 20px;
            border-radius: 10px;
            position: relative;
        }
        #addQuestion{
            display: none;
            justify-content: center;
        }
        form{
            display: grid;
            justify-content: center;
            margin: auto;
        }

    </style>
</head>
<body>
<%
    if(session.getAttribute("admin")==null){
        response.sendRedirect("/login");
    }
%>
<div class="container">
    <main>
        <div class="content-container" id="content-container">
            <div class="change-profile content" id="new-quiz">
                <h1>Edit Quiz</h1>
                <form action="/editQuiz" method="post" id="new-quiz-form">
                    <div class="row">
                        <label for="title">Quiz tittle</label>
                        <input type="text" name="title" id="title" required placeholder="Enter quiz title" >
                    </div>
                    <div class="row">
                        <label for="description">Quiz Description</label>
                        <textarea type="text" id="description" required name="description" ></textarea>
                    </div>
                    <div class="row">
                        <label for="duration">Quiz Duration</label>
                        <input type="number" id="duration" required name="duration" placeholder="edit quiz duration(In minutes)">
                    </div>
                    <button>Save Quiz</button>
                </form>
            </div>
        </div>
    </main>
</div>
</body>
</html>