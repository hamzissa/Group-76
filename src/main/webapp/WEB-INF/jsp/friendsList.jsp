<%--
  Created by IntelliJ IDEA.
  User: georgeoji
  Date: 25/03/2026
  Time: 20:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
  <title>My Friends</title>
  <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
<div class="page-header">
  <a class="btn btn-outline" href="/dashboard">← Dashboard</a>
  <h1>My Friends</h1>
  <a class="btn btn-primary" href="/friends/leaderboard">Leaderboard</a>
</div>

<div class="page-wrapper">
  <c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
  </c:if>

  <p class="section-label">Friends (${friendList.size()})</p>
  <c:forEach var="friend" items="${friendList}">
    <div class="friend-item">
      <div class="friend-avatar">${fn:toUpperCase(fn:substring(friend.email, 0, 2))}</div>
      <span class="friend-email">${friend.email}</span>
      <span class="friend-id">#${friend.id}</span>
      <form action="/friends/remove" method="post" style="display:inline;">
        <input type="hidden" name="friendId" value="${friend.id}">
        <button type="submit" class="btn btn-danger">Remove</button>
      </form>
    </div>
  </c:forEach>
</div>
</body>
