<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Courses</title>
    <style>
        body {
            margin: 0;
            font-family: "Nunito", sans-serif;
            background: #eef2f7;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 500px;
            padding: 40px;
            background: white;
            border-radius: 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 800;
            color: #333;
        }

        input {
            width: 100%;
            padding: 16px;
            margin: 12px 0;
            border-radius: 20px;
            border: 1px solid #ddd;
            background: #f7f9fc;
            box-sizing: border-box;
        }

        input:focus {
            border-color: #4e73df;
            outline: none;
        }

        button {
            width: 100%;
            padding: 16px;
            margin-top: 10px;
            border: none;
            border-radius: 20px;
            background: #4e73df;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #2e59d9;
        }

        ul {
            list-style: none;
            padding: 0;
            margin-top: 20px;
        }

        li {
            background: #f7f9fc;
            padding: 12px;
            margin-bottom: 10px;
            border-radius: 15px;
        }

        .link {
            text-align: center;
            margin-top: 20px;
        }

        .link a {
            color: #4e73df;
            font-weight: 700;
            text-decoration: none;
        }

        .empty {
            text-align: center;
            margin-top: 15px;
            color: #db4437;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Search Courses</h2>

    <form action="/search" method="post">
        <input type="text" id="keyword" name="keyword"
               placeholder="Search courses..."
               value="${filter.keyword}" />
        <button type="submit">Search</button>
    </form>

    <c:if test="${not empty searchResults}">
        <ul>
            <c:forEach var="course" items="${searchResults}">
                <li>
                        ${course.name}
                </li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${empty searchResults}">
        <div class="empty">
            No courses found matching your criteria.
        </div>
    </c:if>

    <div class="link">
        <a href="/dashboard">Back to Dashboard</a>
    </div>

</div>

</body>
</html>