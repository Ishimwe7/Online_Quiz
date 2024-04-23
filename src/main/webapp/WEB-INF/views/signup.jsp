<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 3/30/2024
  Time: 3:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <link rel="stylesheet" href="CSS/signStyles.css">
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: black;
        }

        .container {
            max-width: 400px;
            margin: 30px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: grid;
            justify-content: center;
            position: relative;
        }

        .container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        /*form{*/
        /*    margin: auto;*/
        /*}*/

        .input-group {
            margin-bottom: 15px;
            width: 100%;
            position: relative;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        p {
            text-align: center;
        }

        p a {
            color: #007bff;
            text-decoration: none;
        }

        p a:hover {
            text-decoration: underline;
        }
        .message{
            text-align: center;
            margin: 10px;
            font-size: larger;
        }
        p.success{
            color: green;
        }
        p.error{
            color: red;
        }
        button{
            display: flex;
            margin: 10px auto;
            justify-content: center;
            font-size: larger;
            padding: 3px;
            border-radius: 15px;
            width: 100%;
            background: black;
            color: white;
        }
        button:hover{
            cursor: pointer;
            opacity: 0.7;
        }
        span{
            color: red;
        }
        .log{
            margin: 10px;
        }
        #tutor label{
            display: inline;
            font-size: x-large;
            font-weight: bold;
        }
        #tutor input{
            width: 20px;
            height: 20px;
            margin-left: 10px;
        }

    </style>
</head>
<body>
<div class="container">
    <form action="/register" method="post" modelAttribute="user">
        <h2>User Registration</h2>
        <div class="input-group">
            <label for="name">Name <span>*</span></label>
            <input type="text" id="name" name="username" required>
        </div>
        <div class="input-group">
            <label for="email">Email <span>*</span></label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="input-group">
            <label for="password">Password <span>*</span></label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="input-group">
            <label for="confirm-password">Confirm Password <span>*</span></label>
            <input type="password" id="confirm-password" name="confirmPass" required>
        </div>
<%--        <div  id="tutor">--%>
<%--            <label for="admin">Tutor</label>--%>
<%--            <input id="admin" type="checkbox" name="isAdmin">--%>
<%--        </div>--%>
        <%if(request.getAttribute("passMis")!=null){%>
        <p class="error message" style="color: red"><%=request.getAttribute("passMis")%></p>
        <%}%>
        <%if(request.getAttribute("emailExists")!=null){%>
        <p class="error message" style="color: red"><%=request.getAttribute("emailExists")%></p>
        <%}%>
        <button type="submit">Sign Up</button>
        <%if(request.getAttribute("error")!=null){%>
        <p class="error message" style="color: red"><%=request.getAttribute("error")%></p>
        <%}%>
        <%if(request.getAttribute("success")!=null){%>
        <p class="success message" style="color: green"><%=request.getAttribute("success")%></p>
        <%}%>
        <%if(request.getAttribute("invalidEmail")!=null){%>
        <p class="error" style="color: red"><%=request.getAttribute("invalidEmail")%></p>
        <%}%>
        <%if(request.getAttribute("invalidPassword")!=null){%>
        <p class="error" style="color: red"><%=request.getAttribute("invalidPassword")%></p>
        <%}%>
        <p class="log">Already have an account? <a href="/login">Log In</a></p>
    </form>
</div>
</body>
</html>
