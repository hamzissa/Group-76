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
            width:760px;
            max-width:100%;
            background:white;
            border-radius:24px;
            box-shadow:0 15px 40px rgba(0,0,0,0.08);
            padding:22px;
        }
        h1{
            margin:0 0 6px;
            font-size:18px;
            font-weight:900;
            color:#111827;
        }
        .sub{
            margin:0 0 18px;
            color:#6b7280;
            font-weight:700;
            font-size:12px;
        }
        .row{
            display:flex;
            justify-content:space-between;
            padding:14px;
            border-radius:18px;
            background:#f7f9fc;
            border:1px solid #e5e7eb;
            margin-bottom:10px;
        }
        .name{
            font-weight:900;
        }
        .date{
            font-size:12px;
            color:#6b7280;
        }
        .empty{
            padding:14px;
            border-radius:18px;
            background:#fff7ed;
            border:1px solid #fed7aa;
            color:#9a3412;
            font-weight:800;
        }
        .input-row{
            display:flex;
            gap:10px;
            margin-bottom:18px;
        }
        .input-row input{
            flex:1;
            padding:10px;
            border-radius:14px;
            border:1px solid #ddd;
        }
        .input-row button{
            padding:10px 14px;
            border-radius:14px;
            border:none;
            background:#4e73df;
            color:white;
            font-weight:800;
            cursor:pointer;
        }
        .input-row button:hover{
            background:#2e59d9;
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
    <p class="sub">Completed courses are recorded here.</p>

    <form action="/completion/mark" method="post" class="input-row">
        <input name="courseName" placeholder="Enter course name" required />
        <button type="submit">Mark Completed</button>
    </form>

    <c:if test="${empty completions}">
        <div class="empty">No completed courses yet.</div>
    </c:if>

    <c:if test="${not empty completions}">
        <c:forEach var="c" items="${completions}">
            <div class="row">
                <div class="name">${c.courseName}</div>
                <div class="date">${c.completedAt}</div>
            </div>
        </c:forEach>
    </c:if>

    <a class="btn" href="/dashboard">Back to dashboard</a>

</div>
</body>
</html>