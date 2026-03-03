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

        .user-info {
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            margin-bottom: 20px;
            text-align: center;
        }
        .badge-preview {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        .badge-thumbnail {
            width: 60px;
            height: 60px;
            margin: 0 auto;
            opacity: 0.7;
            transition: opacity 0.3s;
        }
        .badge-thumbnail:hover {
            opacity: 1;
            cursor: pointer;
        }
        .badge-thumbnail.earned {
            opacity: 1;
        }
        .view-all-badges {
            display: block;
            margin-top: 15px;
            color: #667eea;
            font-weight: bold;
            text-decoration: none;
            font-size: 14px;
        }
        .view-all-badges:hover {
            color: #764ba2;
        }
    </style>
</head>
<body>
<img src="/images/IBM-Logo.jpg" alt="IBM logo" style="width: 100px; vertical-align: middle;">
    <h1>IBM SkillsBuild Courses</h1>

    <div class="user-info">
        <p>Welcome, ${user.email}!</p>
        <p style="font-size: 20px; color: #667eea; font-weight: bold;">⭐ XP: ${user.xp}</p>
        
        <div class="badge-preview">
            <c:forEach var="badge" items="${earnedBadges}">
                <img src="${badge.imagePath}" alt="${badge.name}" class="badge-thumbnail earned" title="${badge.name}">
            </c:forEach>
            <c:forEach var="badge" items="${unearnedBadges}" begin="0" end="2">
                <img src="${badge.imagePath}" alt="${badge.name}" class="badge-thumbnail" title="${badge.name} - Unlock at ${badge.requiredXp} XP">
            </c:forEach>
        </div>
        
        <a href="/badges" class="view-all-badges">🏆 View All Badges →</a>
    </div>

    <ul>
       <c:forEach var="course" items="${courses}">
           <li>
               <c:url var="startLink" value="/start-course">
                   <c:param name="url" value="${course.url}" />
                   <c:param name="name" value="${course.name}" />
               </c:url>

               <a href="${startLink}">
                   ${course.name}
               </a>
           </li>
       </c:forEach>

        <li>
            <a href="/course-progress">View Course Progress</a>
        </li>
        <li>
            <a href="/completion">View Completion History</a>
        </li>
        <li>
            <a href="/search">Search Courses</a>
        </li>
    </ul>

</body>
</html>
