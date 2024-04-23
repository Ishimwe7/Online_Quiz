<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <title>Quizify</title>
<%--    <link rel="stylesheet" href="./CSS/styles.css">--%>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: black;
        }

        .container {
            max-width: 800px;
            margin: 150px auto;
            text-align: center;
            background: black;
        }

        header h1 {
            font-size: 45px;
            margin-bottom: 10px;
            color: white;
        }

        header p {
            font-size: 25px;
            margin-bottom: 30px;
            color: white;
        }
        .buttons button {
            padding: 10px 20px;
            margin-right: 10px;
            border-radius: 5px;
            background-color: white;
            color: black;
            font-size: 16px;
            cursor: pointer;
        }

        .image {
            margin-top: 30px;
            /* Add styles for the image container if needed */
        }

        .buttons button a{
            text-decoration: none;
            color: black;
            font-weight: bolder;
            font-size: x-large;
        }
    </style>
</head>
<body>
<div class="container">
    <header>
        <h1>Welcome to Quizify!</h1>
        <p>Test your knowledge with fun quizzes</p>
    </header>
    <div class="buttons">
        <button id="loginBtn"><a href="/login">Login
            <span class="material-icons-sharp">login</span></a></button>
        <button id="signupBtn"><a href="/signup">Sign Up<span class="material-icons-sharp">how_to_reg
</span>
        </a></button>
    </div>
    <div class="image">
        <!-- Image Placeholder -->
    </div>
</div>
<script src="script.js"></script>
</body>
</html>