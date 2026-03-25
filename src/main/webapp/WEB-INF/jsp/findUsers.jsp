<%--
  Created by IntelliJ IDEA.
  User: georgeoji
  Date: 25/03/2026
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <title>Find Friends</title>
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
<div class="page-header">
    <a class="btn btn-outline" href="/dashboard">← Dashboard</a>
    <h1>Find Friends</h1>
    <div></div>
</div>

<div class="page-wrapper">
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">${errorMessage}</div>
    </c:if>
    <c:if test="${not empty invalid_inputMessage}">
        <div class="alert alert-error">${invalid_inputMessage}</div>
    </c:if>

    <form action="/friends/find" method="get" class="search-bar">
        <input class="search-input" type="text" name="friendID" placeholder="Search by user ID…">
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <p class="section-label">All Users</p>
    <c:forEach var="user" items="${userList}">
        <div class="friend-item">
            <div class="friend-avatar">${fn:substring(user.email,0,2)}</div>
            <span class="friend-email">${user.email}</span>
            <span class="friend-id">#${user.id}</span>
            <form action="/friends/add" method="post">
                <input type="hidden" name="friendId" value="${user.id}">
                <button type="submit" class="btn btn-primary">+ Add</button>
            </form>
        </div>
    </c:forEach>
</div>
</body>
