<%@ page import="com.nyanja.online_quiz.model.Quiz" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nyanja.online_quiz.model.User" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 4/1/2024
  Time: 5:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        #add_question{
            background: green;
        }
        #quiz_questions{
            background: dodgerblue;
        }
        .quiz-title{
            font-size: x-large;
            font-weight: bold;
            margin-top: 10px;
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
            top: 10px;
        }
        #quizes{
            width: 100%;
            padding: 30px;
            position: relative;
        }
        .quiz{
            width: 100%;
            background: #9bb4e0;
            margin: 20px auto;
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

        .editForm{
            display: none;
            background: #cbd9f3;
            border-radius: 10px;
            z-index: 222;
            position: absolute;
            top: 0vh;
            right: 35px;
            padding: 20px 0;
            width: 450px;
        }
        .editBtn{
            background: yellow;
        }
        .quiz-actions .editBtn {
            color: black;
        }
        #edit-quiz textarea{
            width: 300px;
            height: 70px;
        }
        #edit-quiz .row{
            width: 100%;
        }
        #edit-quiz input{
            width: 100%;
        }
        #editBtns {
            display: flex;
            justify-content: center;
        }
        #editBtns button{
            width: 120px;
            border: 1px solid white;
        }
        #editBtns #saveBtn{
            background: blue;
            color: white;
        }
        /*#editBtns #cancelBtn{*/
        /*    background: re;*/
        /*}*/
        /*.editForm{*/
        /*    display: none;*/
        /*}*/
       .edit-btn{
           border-radius: 5px;
       }
        .closeEdit{
            position: absolute;
            top: 10px;
            right: 20px;
        }
        .closeEdit:hover{
            cursor: pointer;
        }
    </style>
</head>
<body>
<%
    if(session.getAttribute("admin")==null){
        response.sendRedirect("/login");
    }
    User admin = (User)session.getAttribute("admin");
%>
<div class="container">
    <aside>
        <div class="top">
            <div class="logo">
<%--                <img src="../pictures/logo.PNG" alt="my logo">--%>
<%--                <h1>${user.email}</h1>--%>
                <h1><%=admin.getUsername() +" @"+"Quizify"%></h1>
<%--                <h1>Quizify</h1>--%>
            </div>
            <div class="close" id="close-btn">
                    <span class="material-icons-sharp">
                        close
                    </span>
            </div>
        </div>
        <div class="sidebar">
            <a href="#" class="active" onclick="showChangeProfile('change-profile')">
                <span class="material-icons-sharp">person</span>
                <h3>Profile</h3>
            </a>
            <a href="#new-quiz" id="add-quiz">
                <span class="material-icons-sharp">add</span>
                <h3>Create Quiz</h3>
            </a>
            <a href="#quizes" id="all-quizzes" onclick="showQuizzes('quiz-section')">
                <span class="material-icons-sharp">toc</span>
                <h3>My Quizzes</h3>
            </a>
            <a href="/logout" id="admin-logout">
                <span class="material-icons-sharp">logout</span>
                <h3>Logout</h3>
            </a>
        </div>
    </aside>
    <main>
        <h1>Admin's Dashboard</h1>
        <div class="content-container" id="content-container">
            <div class="welcome content" id="welcome">
                <h1>Welcome Back to your Dashboard</h1>
            </div>
            <div class="change-profile content" id="new-quiz">
                <h1>Create new Quiz</h1>
                <form action="/createQuiz" method="post" id="new-quiz-form">
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
                        <input type="number" id="duration" required name="duration" placeholder="Set quiz duration(In minutes)">
                    </div>
                    <button>Save Quiz</button>
                </form>
            </div>
            <div class="users content" id="users">
                <h1>All Quizzes List</h1>
                <div id="quizes">
                    <%List<Quiz> quizzes = (List<Quiz>)request.getAttribute("quizzes");%>
                <% for (Quiz quiz : (List<Quiz>)request.getAttribute("quizzes")) { %>
                    <%if(quizzes.isEmpty()){%>
                    <p>No created quizzes yet !</p>
                    <%}%>
                <div class="quiz" id="<%=quiz.getId()%>">
                    <!-- Display quiz details here -->
                    <%
                        long quizId= quiz.getId();
                        request.setAttribute("quizId",quizId);
                    %>
                    <h3 class="quiz-title"> <%= quiz.getTitle() %> </h3><br>
                    <p class="quiz-desc"> <%= quiz.getDescription() %></p><br>
                    <p class="duration">Time limit : <span class="limit"><%=quiz.getDuration()%></span> Minutes</p>
                    <div class="quiz-actions">
<%--                        <a id="quiz_questions" class="actionButton">View Related Questions</a>--%>
                        <a id="add_question" class="actionButton add_question" href="createQuestion/<%=quiz.getId()%>">Add Question</a>
                        <a id="editQuiz<%=quiz.getId()%>" class="actionButton editBtn">Edit Quiz</a>
<%--                        <a id="deleteQuiz" class="actionButton" href="/deleteQuiz/<%=quiz.getId()%>">Delete Quiz</a>--%>
                    </div>
                    <!-- Add more details as needed -->
                </div>
                    <div class="change-profile content editForm" id="edit-quiz<%=quiz.getId()%>">
                        <span id="cancelBtn<%=quiz.getId()%>" class="material-icons-sharp closeEdit">close</span>
                        <h1>Edit Quiz</h1>
                        <form action="/editQuiz/<%=quiz.getId()%>" method="post" id="edit-quiz-form">
                            <div class="row">
                                <label for="title">Quiz tittle</label>
                                <input type="text" name="title" value="<%=quiz.getTitle()%>" id="edit-title" required placeholder="Enter quiz title" >
                            </div>
                            <div class="row">
                                <label for="description">Quiz Description</label>
                                <textarea type="text" id="edit-description<%=quiz.getId()%>"  required name="description" ></textarea>
                            </div>
                            <div class="row">
                                <label for="duration">Quiz Duration</label>
                                <input type="number" id="edit-duration" value="<%=quiz.getDuration()%>" required name="duration" placeholder="edit quiz duration(In minutes)">
                            </div>
                            <div id="editBtns">
                                <button type="submit" class="edit-btn" id="saveBtn<%=quiz.getId()%>">Save</button>
                            </div>
                            <%String success = (String) request.getAttribute("success");%>
                                <%if(success!=null){%>
                                    <script>alert(<%=success%>)</script>
                           <%}%>
                            <script>
                                document.getElementById("editQuiz"+<%=quiz.getId()%>).addEventListener('click',()=>{
                                    document.getElementById("edit-description<%=quiz.getId()%>").textContent="<%=quiz.getDescription()%>";
                                    document.getElementById("edit-quiz"+<%=quiz.getId()%>).style.display="block";
                                    console.log("clicked")
                                })
                                document.getElementById("cancelBtn"+<%=quiz.getId()%>).addEventListener('click',()=>{
                                    document.getElementById("edit-quiz"+<%=quiz.getId()%>).style.display="none";
                                    console.log("clicked")
                                })
                            </script>
                        </form>
                    </div>
                <% } %>
                </div>
            </div>
            <div id="addQuestion" class="content">
                <h1>Add Question to Quiz</h1>
                <form action="/addQuestion" id="qst-form" method="post">
                    <div class="row">
                        <label for="question">Question</label>
                        <input type="text" id="question" name="question" placeholder="Write Question here">
                    </div>
                    <div class="row">
                        <label for="option1">Option 1</label>
                        <input type="text" id="option1"  name="option1" placeholder="Enter answer option 1">
                    </div>
                    <div class="row">
                        <label for="option1">Option 2</label>
                        <input type="text" id="option2"  name="option2" placeholder="Enter answer option 2">
                    </div>
                    <div class="row">
                        <label for="option1">Option 3</label>
                        <input type="text" id="option3"  name="option3" placeholder="Enter answer option 3">
                    </div>
                    <div class="row">
                        <label for="option1">Option 4</label>
                        <input type="text" id="option4"  name="option1" placeholder="Enter answer option 4">
                    </div>
                    <div class="row">
                        <label for="option5">Option 5</label>
                        <input type="text" id="option5"  name="option1" placeholder="Enter answer option 5">
                    </div>
<%--                    <%--%>
<%--                        request.setAttribute("quizId",request.getAttribute("quizId"));--%>
<%--                    %>--%>
                    <button type="submit">Add Question</button>
                </form>
            </div>
        </div>
    </main>
</div>
<%--<script>--%>
<%--    // function displayEdit(){--%>
<%--    //     const editForm =document.getElementById("edit-quiz");--%>
<%--    //     editForm.style.display="grid";--%>
<%--    // }--%>
<%--    const displayEdit =()=>{--%>
<%--        console.log("Clicked")--%>
<%--        const editForm =document.getElementById("edit-quiz");--%>
<%--        editForm.style.display="grid";--%>
<%--        // const editTitle = document.getElementById("edit-title");--%>
<%--        // const editDesc = document.getElementById("edit-description");--%>
<%--        // const dur = document.getElementById("edit-duration");--%>
<%--        // editTitle.textContent=title;--%>
<%--        // editDesc.textContent=desc;--%>
<%--        // dur.textContent=duration;--%>
<%--    }--%>
<%--    document.getElementById("cancelBtn").onclick=function closeEdit(){--%>
<%--        const editForm =document.getElementById("edit-quiz");--%>
<%--        editForm.style.display="none";--%>
<%--    }--%>
<%--    // const content_container = document.getElementById("content-container");--%>
<%--    // function addQuestion(){--%>
<%--    //     const addQuestion = document.getElementById("addQuestion");--%>
<%--    //     addQuestion.style.display="grip";--%>
<%--    // }--%>
<%--    // function removeContent() {--%>
<%--    //     // Hide all content sections--%>
<%--    //     var contentSections = document.querySelectorAll('.content');--%>
<%--    //     contentSections.forEach(function (section) {--%>
<%--    //         section.style.display = 'none';--%>
<%--    //     });--%>
<%--    //--%>
<%--    // }--%>
<%--    // function addSection(sectionId){--%>
<%--    //     const section = document.getElementById(sectionId);--%>
<%--    //     if(section){--%>
<%--    //         section.style.display="grid";--%>
<%--    //     }--%>
<%--    // }--%>
<%--    // function addEventListerToAddQuestion(){--%>
<%--    //     const addQuestiion = document.querySelector(".add_question");--%>
<%--    //     addQuestiion.forEach(function (addQst){--%>
<%--    //         addQst.addEventListener("click",function (){--%>
<%--    //             removeContent();--%>
<%--    //             addSection(sectionId);--%>
<%--    //         });--%>
<%--    //     });--%>
<%--    // }--%>
<%--</script>--%>
</body>
</html>