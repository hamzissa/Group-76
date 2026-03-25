<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IBM SkillsBuild Dashboard</title>
    <style>
        body {
            font-family: "Times New Roman", Arial, sans-serif;
            background-color: cornflowerblue;
            margin: 0;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        ul {
            max-width: 500px;
            margin: 20px auto;
            padding: 0;
            list-style: none;
            width: 100%;
        }
        li {
            background: white;
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
        a {
            text-decoration: none;
            color: #0066cc;
            font-weight: 500;
            font-size: 18px;
            display: block;
            padding: 15px 20px;
        }
        a:hover {
            color: #004499;
        }
        .user-info {
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            margin-bottom: 20px;
            text-align: center;
            width: 100%;
            max-width: 760px;
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
        .reviews-panel {
            background: white;
            padding: 18px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            margin-bottom: 20px;
            width: 100%;
            max-width: 760px;
        }
        .reviews-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 12px;
            color: #333;
        }
        .review-item {
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            background: #f8fafc;
            padding: 12px;
            margin-bottom: 10px;
        }
        .review-course {
            font-weight: bold;
            color: #111827;
        }
        .review-stars {
            color: #d97706;
            margin: 4px 0;
            font-size: 18px;
        }
        .review-comment {
            color: #374151;
        }
        .review-meta {
            font-size: 12px;
            color: #6b7280;
            margin-top: 6px;
        }
        .goal-panel {
            background: white;
            padding: 18px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            margin-bottom: 20px;
            width: 100%;
            max-width: 760px;
        }
        .goal-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 12px;
            color: #333;
        }
        .goal-bar-bg {
            background-color: #e5e7eb;
            height: 20px;
            border-radius: 8px;
            overflow: hidden;
            margin-top: 10px;
        }
        .goal-bar-fill {
            background: linear-gradient(90deg, #5ba360, #76c77a);
            height: 100%;
            width: 0%;
        }
        .goal-status {
            margin-top: 10px;
            font-weight: bold;
        }
        .goal-link {
            display: inline-block;
            margin-top: 12px;
            color: #4a81bd;
            font-weight: bold;
            text-decoration: none;
            font-size: 14px;
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

    <c:if test="${not empty activeGoal}">
        <div class="goal-panel">
            <div class="goal-title">🎯 Current Goal Progress</div>
            <div>${activeGoal.completedCount} / ${activeGoal.target} Courses Completed</div>

            <div class="goal-bar-bg">
                <div class="goal-bar-fill"
                     id="dashboardGoalBar"
                     data-comp="${activeGoal.completedCount}"
                     data-total="${activeGoal.target}">
                </div>
            </div>

            <div class="goal-status">
                <c:choose>
                    <c:when test="${dashboardDeadlinePassed && activeGoal.completedCount < activeGoal.target}">
                        Deadline passed — set a new goal.
                    </c:when>
                    <c:when test="${activeGoal.completedCount >= activeGoal.target}">
                        Goal achieved! 🎉
                    </c:when>
                    <c:otherwise>
                        Keep going — you're making progress.
                    </c:otherwise>
                </c:choose>
            </div>

            <a href="/goalTracker" class="goal-link">View Goal Tracker →</a>
        </div>
    </c:if>

    <div class="reviews-panel">
        <div class="reviews-title">Recent Reviews</div>

        <c:if test="${empty recentReviews}">
            <div>No reviews yet.</div>
        </c:if>

        <c:if test="${not empty recentReviews}">
            <c:forEach var="review" items="${recentReviews}">
                <div class="review-item">
                    <div class="review-course">${review.courseName}</div>
                    <div class="review-stars">${review.stars}</div>
                    <div class="review-comment">${review.comment}</div>
                    <div class="review-meta">Completed on ${review.formattedCompletedAt}</div>
                </div>
            </c:forEach>
        </c:if>
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
        <li>
            <a href="/leaderboard">Leaderboard</a>
        </li>
        <li>
            <a href="/goalTracker">Goal Tracker</a>
        </li>
        <li>
            <a href="/popular-courses">Popular Courses</a>
        </li>
    </ul>

<script>
    var dashboardBar = document.getElementById("dashboardGoalBar");
    if (dashboardBar) {
        var comp = parseFloat(dashboardBar.getAttribute("data-comp")) || 0;
        var total = parseFloat(dashboardBar.getAttribute("data-total")) || 0;
        var pct = total > 0 ? (comp / total) * 100 : 0;
        if (pct > 100) {
            pct = 100;
        }
        dashboardBar.style.width = pct + "%";
    }
</script>

</body>
</html>