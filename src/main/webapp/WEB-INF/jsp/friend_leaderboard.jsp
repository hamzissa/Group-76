<%--
  Created by IntelliJ IDEA.
  User: georgeoji
  Date: 25/03/2026
  Time: 20:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <title>Friends XP Leaderboard</title>
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
<div class="page-header">
    <a class="btn btn-outline" href="/friends/list">← Friends</a>
    <h1>XP Leaderboard</h1>
    <div></div>
</div>

<div class="page-wrapper">
    <p class="section-label">Rankings</p>
    <ul class="leaderboard-list">
        <c:forEach var="user" varStatus="status" items="${Leaderboard}">
            <li class="leaderboard-item">
                <span class="leaderboard-rank">${status.index + 1}</span>
                <div class="friend-avatar">${fn:substring(user.email,0,2)}</div>
                <span class="leaderboard-email">${user.email}</span>
                <span class="leaderboard-xp">${user.xp} XP</span>
            </li>
        </c:forEach>
    </ul>
</div>
</body>