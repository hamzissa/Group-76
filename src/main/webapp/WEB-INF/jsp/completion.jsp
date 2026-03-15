<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Completion History</title>

<style>
body{
    margin:0;
    font-family:"Nunito", system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
    background:#eef2f7;
    min-height:100vh;
    display:flex;
    justify-content:center;
    padding:32px 16px;
    box-sizing:border-box;
}
.card{
    width:900px;
    max-width:100%;
    background:white;
    border-radius:24px;
    box-shadow:0 15px 40px rgba(0,0,0,0.08);
    padding:22px;
}
h1{
    margin:0 0 6px;
    font-size:20px;
    font-weight:900;
    color:#111827;
}
.sub{
    margin:0 0 18px;
    color:#6b7280;
    font-weight:700;
    font-size:13px;
}
.message-success{
    background:#ecfdf5;
    color:#166534;
    border:1px solid #bbf7d0;
    padding:12px;
    border-radius:14px;
    margin-bottom:16px;
    font-weight:800;
}
.message-error{
    background:#fef2f2;
    color:#991b1b;
    border:1px solid #fecaca;
    padding:12px;
    border-radius:14px;
    margin-bottom:16px;
    font-weight:800;
}
.input-row{
    display:flex;
    gap:10px;
    margin:18px 0;
}
.input-row input{
    flex:1;
    padding:10px;
    border-radius:12px;
    border:1px solid #ddd;
}
.input-row button{
    padding:10px 14px;
    border:none;
    border-radius:12px;
    background:#4e73df;
    color:white;
    font-weight:800;
    cursor:pointer;
}
.toolbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:16px;
    gap:12px;
    flex-wrap:wrap;
}
.sort-form{
    display:flex;
    align-items:center;
    gap:8px;
}
.sort-form select{
    padding:8px 10px;
    border-radius:10px;
    border:1px solid #ddd;
}
.sort-form button{
    padding:8px 12px;
    border:none;
    border-radius:10px;
    background:#111827;
    color:white;
    font-weight:800;
    cursor:pointer;
}
.row{
    padding:16px;
    border-radius:18px;
    background:#f7f9fc;
    border:1px solid #e5e7eb;
    margin-bottom:14px;
}
.top-row{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    gap:18px;
    margin-bottom:10px;
}
.name{
    font-weight:900;
    font-size:16px;
    color:#111827;
}
.date{
    font-size:12px;
    color:#6b7280;
    white-space:nowrap;
}
.meta{
    display:flex;
    gap:18px;
    flex-wrap:wrap;
    margin-bottom:10px;
    font-size:13px;
    font-weight:700;
    color:#374151;
}
.average{
    color:#1d4ed8;
}
.review-box{
    margin-top:10px;
    padding-top:12px;
    border-top:1px solid #dbe3f0;
}
.review-title{
    font-weight:900;
    margin-bottom:8px;
    color:#374151;
}
.review-form{
    display:flex;
    flex-direction:column;
    gap:10px;
}
.review-form select,
.review-form textarea{
    width:100%;
    padding:10px;
    border-radius:10px;
    border:1px solid #ddd;
    box-sizing:border-box;
    font-family:inherit;
}
.review-form textarea{
    min-height:90px;
    resize:vertical;
}
.review-form button{
    width:170px;
    padding:10px;
    border:none;
    border-radius:10px;
    background:#16a34a;
    color:white;
    font-weight:800;
    cursor:pointer;
}
.saved-review{
    background:#eef6ff;
    border:1px solid #c7dbff;
    border-radius:12px;
    padding:10px;
    margin-bottom:10px;
}
.stars{
    font-size:20px;
    color:#facc15;
    margin-bottom:6px;
}
.saved-comment{
    color:#374151;
    white-space:pre-wrap;
}
.empty{
    padding:14px;
    border-radius:18px;
    background:#fff7ed;
    border:1px solid #fed7aa;
    color:#9a3412;
    font-weight:800;
}
.btn{
    display:inline-block;
    margin-top:12px;
    text-decoration:none;
    background:#4e73df;
    color:white;
    font-weight:900;
    padding:10px 12px;
    border-radius:16px;
}
</style>
</head>
<body>
<div class="card">

    <h1>Completion History</h1>
    <p class="sub">Completed courses are recorded here. You can leave a rating and comment after completing a course.</p>

    <c:if test="${not empty successMessage}">
        <div class="message-success">${successMessage}</div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="message-error">${errorMessage}</div>
    </c:if>

    <form action="/completion/mark" method="post" class="input-row">
        <input name="courseName" list="courseList" placeholder="Enter course name" required />
        <datalist id="courseList">
            <option value="Artificial Intelligence">
            <option value="Data Science">
            <option value="Security">
            <option value="Quantum Computing">
        </datalist>
        <button type="submit">Mark Completed</button>
    </form>

    <div class="toolbar">
        <div class="sub" style="margin:0;">Sort your completed courses</div>
        <form action="/completion" method="get" class="sort-form">
            <select name="sort">
                <option value="recent" ${sort == 'recent' ? 'selected' : ''}>Most Recent</option>
                <option value="highest" ${sort == 'highest' ? 'selected' : ''}>Highest Rated</option>
                <option value="lowest" ${sort == 'lowest' ? 'selected' : ''}>Lowest Rated</option>
            </select>
            <button type="submit">Apply</button>
        </form>
    </div>

    <c:if test="${empty completions}">
        <div class="empty">No completed courses yet.</div>
    </c:if>

    <c:if test="${not empty completions}">
        <c:forEach var="c" items="${completions}">
            <div class="row">
                <div class="top-row">
                    <div class="name">${c.courseName}</div>
                    <div class="date">${c.formattedCompletedAt}</div>
                </div>

                <div class="meta">
                    <div class="average">
                        Average Rating:
                        <c:choose>
                            <c:when test="${averageRatings[c.courseName] == 'No ratings yet'}">
                                No ratings yet
                            </c:when>
                            <c:otherwise>
                                ${averageRatings[c.courseName]}/5 (${ratingCounts[c.courseName]} reviews)
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="review-box">
                    <div class="review-title">
                        <c:choose>
                            <c:when test="${c.rating != null}">Your Review</c:when>
                            <c:otherwise>Leave a Review</c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${c.rating != null}">
                        <div class="saved-review">
                            <div class="stars">${c.stars}</div>
                            <div class="saved-comment">${c.comment}</div>
                        </div>
                    </c:if>

                    <form action="/completion/review" method="post" class="review-form">
                        <input type="hidden" name="courseName" value="${c.courseName}" />

                        <select name="rating" required>
                            <option value="">Select rating</option>
                            <option value="1" ${c.rating == 1 ? 'selected' : ''}>⭐ 1</option>
                            <option value="2" ${c.rating == 2 ? 'selected' : ''}>⭐⭐ 2</option>
                            <option value="3" ${c.rating == 3 ? 'selected' : ''}>⭐⭐⭐ 3</option>
                            <option value="4" ${c.rating == 4 ? 'selected' : ''}>⭐⭐⭐⭐ 4</option>
                            <option value="5" ${c.rating == 5 ? 'selected' : ''}>⭐⭐⭐⭐⭐ 5</option>
                        </select>

                        <textarea name="comment" minlength="10" required placeholder="Leave a comment about this course">${c.comment}</textarea>

                        <button type="submit">
                            <c:choose>
                                <c:when test="${c.rating != null}">Update Review</c:when>
                                <c:otherwise>Submit Review</c:otherwise>
                            </c:choose>
                        </button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </c:if>

    <a class="btn" href="/dashboard">Back to dashboard</a>
</div>
</body>
</html>