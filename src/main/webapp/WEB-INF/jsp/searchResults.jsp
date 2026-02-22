<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
</head>
<body>
    <h1>Search Results</h1>
    <p>This page will display the results of your course search.</p>
    
    <c:if test="${not empty searchResults}">
        <ul>
            <c:forEach var="course" items="${searchResults}">
                <li>${course.name}</li>
            </c:forEach>
        </ul>
    </c:if>
    <c:if test="${empty searchResults}">
        <p>No courses found matching your criteria.</p>
    </c:if>
    
    <p><a href="/dashboard">Back to Dashboard</a></p>
</body>
</html>