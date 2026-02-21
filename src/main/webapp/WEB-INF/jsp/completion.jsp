<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Completion History</title>
</head>
<body>
<h1>Completion History</h1>

<c:if test="${empty completions}">
    <p>No completed courses yet.</p>
</c:if>

<c:if test="${not empty completions}">
    <ul>
        <c:forEach var="c" items="${completions}">
            <li>
                <strong>${c.courseName}</strong>
                — Completed: ${c.completedAt}
            </li>
        </c:forEach>
    </ul>
</c:if>

<p><a href="/dashboard">Back to Dashboard</a></p>
</body>
</html>