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
            color: #2d3748;
        }

        .course {
            background: #f7f9fc;
            padding: 15px;
            margin: 10px 0;
            border-radius: 12px;
            transition: 0.2s;
            position: relative;
        }

        .course:hover {
            background: #e3e9f7;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .course-link {
            text-decoration: none;
            font-weight: bold;
            color: #4e73df;
            font-size: 16px;
        }

        .course-link:hover {
            color: #2e59d9;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background: #4e73df;
            color: white;
            padding: 10px 15px;
            border-radius: 10px;
            transition: 0.2s;
        }

        .btn:hover {
            background: #2e59d9;
        }

        .start-icon {
            font-size: 18px;
            vertical-align: middle;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>🔥 Popular Courses</h1>
    <p style="color: #718096; margin-bottom: 20px;">Click on any course to start learning with progress tracking</p>

    <c:forEach var="course" items="${popularCourses}">
        <div class="course">
            <!-- Auto-start progress timer when clicking course -->
            <c:url var="startLink" value="/start-course">
                <c:param name="url" value="${course.url}"/>
                <c:param name="name" value="${course.name}"/>
            </c:url>
            <a href="${startLink}" class="course-link">
                <span class="start-icon">▶️</span> ${course.name}
            </a>
        </div>
    </c:forEach>

    <a href="/dashboard" class="btn">Back to Dashboard</a>

</div>

</body>
</html>