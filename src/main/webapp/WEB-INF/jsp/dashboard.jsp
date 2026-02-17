<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IBM SkillsBuild Dashboard</title>
    <style>
        body { font-family: "Times New Roman", Arial, sans-serif;
            background-color: cornflowerblue;
            margin: 0;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h1 { text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        ul { max-width: 500px;
            margin: 20px auto;
            padding: 0;
            list-style: none;
            width: 100%;
        }

        li { background: white;
            margin: 10px 0;
            padding: 12px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        li:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 10px rgba(0,0,0,0.15);
        }
        a { text-decoration: none;
            color: #0066cc;
            font-weight: 500;
            font-size: 18px;
            display: block;
            padding: 15px 20px;
        }

        a:hover {color:  #004499;; }

    </style>
</head>
<body>
<img src="/images/IBM-Logo.jpg" alt="IBM logo" style="width: 100px; vertical-align: middle;">
    <h1>IBM SkillsBuild Courses</h1>
    <ul>
        <c:forEach var="course" items="${courses}">
            <li>
                <a href="${course.url}" target="_blank">${course.name}</a>
            </li>
        </c:forEach>
    </ul>

</body>
</html>
