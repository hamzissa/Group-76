<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IBM SkillsBuild Dashboard</title>
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
<nav class="topbar">
    <img src="/images/IBM-Logo.jpg" alt="IBM logo">
    <h1>IBM SkillsBuild Courses</h1>
    <div class="topbar-actions">
        <a class="btn btn-ghost" href="/friends/find">Find Friends</a>
    </div>
</nav>
    <h1>IBM SkillsBuild Courses</h1>

<div class="page-wrapper">
    <div class="user-info-card">
        <div>
            <div class="email">Welcome back,</div>
            <div style="font-size:1.1rem; font-weight:600;">${user.email}</div>
        </div>
        <span class="xp-badge">${user.xp} XP</span>
    </div>

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

<p class="section-label">Courses</p>
<ul class="course-list">
    <c:forEach var="course" items="${courses}">
        <li>
            <c:url var="startLink" value="/start-course">
                <c:param name="url" value="${course.url}"/>
                <c:param name="name" value="${course.name}"/>
            </c:url>
            <a href="${startLink}">${course.name}</a>
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
        <li>
            <a href="/friends/list">View My Friends</a>
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