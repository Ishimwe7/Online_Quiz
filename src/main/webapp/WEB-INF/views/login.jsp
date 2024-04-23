<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 3/30/2024
  Time: 3:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
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
            width: 500px;
            margin: 80px auto;
            background-color: #fff;
            padding: 50px 20px;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            /*display: grid;*/
            /*!*justify-content: center;*!*/
            position: relative;
        }
        #rem{
            margin: 10px auto;
            display: flex;
            gap: 10px;
            font-size: x-large;
            font-weight: bold;
            align-items: center;
            justify-content: left;
            padding-left: 30px;
        }
        #rem input{
            width: 20px;
            height: 20px;
        }

        .container h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 35px;
        }

        /*form{*/
        /*    margin: auto;*/
        /*}*/

        .input-group {
            margin:20px auto;
            width: 85%;
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
            margin: 30px auto;
            justify-content: center;
            font-size: larger;
            padding: 3px;
            border-radius: 15px;
            width: 85%;
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
    </style>
</head>
<body>
<div class="container">
    <form action="/checkUser" method="post">
        <h2>Login</h2>
        <div class="input-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="input-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <%if(request.getAttribute("invalidLogin")!=null){%>
        <p class="error message" style="color: red"><%=request.getAttribute("invalidLogin")%></p>
        <%}%>
        <%if(request.getAttribute("error")!=null){%>
        <p class="error message" style="color: red"><%=request.getAttribute("error")%></p>
        <%}%>
        <button type="submit">Log In</button>
        <div id="rem"><label for="remember">Remember me </label><input id="remember" name="remember" type="checkbox"></div>
        <p>Don't have an account? <a href="/signup">Sign Up</a></p>
    </form>
</div>
</body>
</html>