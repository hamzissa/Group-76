<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Popular Courses</title>

    <style>
        body {
            font-family: "Nunito", sans-serif;
            background: #eef2f7;
            display: flex;
            justify-content: center;
            padding: 40px;
        }

        .container {
            width: 500px;
            background: white;
            padding: 30px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }

        h1 {
            margin-bottom: 20px;
        }

        .course {
            background: #f7f9fc;
            padding: 15px;
            margin: 10px 0;
            border-radius: 12px;
            transition: 0.2s;
        }

        .course:hover {
            background: #e3e9f7;
        }

        a {
            text-decoration: none;
            font-weight: bold;
            color: #4e73df;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background: #4e73df;
            color: white;
            padding: 10px 15px;
            border-radius: 10px;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>🔥 Popular Courses</h1>

    <c:forEach var="course" items="${popularCourses}">
        <div class="course">
            <!-- Direct external link to IBM pages -->
            <a href="${course.url}" target="_blank">
                    ${course.name}
            </a>
        </div>
    </c:forEach>

    <a href="/dashboard" class="btn">Back to Dashboard</a>

</div>

</body>
</html>