<%@ page import="com.nyanja.online_quiz.model.Quiz" %>
<%@ page import="com.nyanja.online_quiz.model.Question" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nyanja.online_quiz.model.Option" %>
<%@ page import="com.nyanja.online_quiz.model.User" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 4/10/2024
  Time: 12:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quiz Results</title>
    <style>
        body{
            background: black;
            color: white;
        }
        .results{
            width: 500px;
            padding: 20px;
            margin: 100px auto;
            color: black;
            background: white;
            border-radius: 30px;
            text-align: center;
        }
        #closeBtn{
            padding: 5px;
            color: white;
            background: black;
            width: 200px;
            height: 40px;
            border-radius: 20px;
            font-size: larger;
        }
        #closeBtn a{
            text-decoration: none;
            color: white;
        }
        #closeBtn:hover{
            cursor: pointer;
            background: dimgray;
            border: 1px solid dimgray;
        }
    </style>
</head>
<body>
<%
    User user = (User)session.getAttribute("user");
    Quiz quiz =(Quiz)session.getAttribute("quiz");
    Integer marks = (int)session.getAttribute("marks");
    int outOff = (int)session.getAttribute("outOff");

    if(user == null || quiz == null){
        response.sendRedirect("/**");
    }
//    marks=(marks*100)/outOff;
    List<Question> questions = (List<Question>)session.getAttribute("questions");
    List<Option> selectedOptions =(List<Option>) session.getAttribute("selectedOptions");
%>
<div class="results">
    <h1><%=quiz.getTitle()%>'s Attempt review</h1>
    <h2>Hello <%=user.getUsername()%> ;</h2>
    <%if(marks>=70){%>
    <h3>Congratulations for getting required score of 70%</h3>
    <%} else{%>
    <h3>We're sorry that you didn't get required score of 70%</h3>
    <%}%>
    <h2>You scored <%=marks%> %</h2>
    <button id="closeBtn" ><a href="/userHome">Close</a></button>
</div>

</body>
</html>
