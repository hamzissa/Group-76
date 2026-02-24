<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
            gap:10px;
            justify-content:space-between;
            align-items:center;
            padding:14px;
            border-radius:18px;
            background:#f7f9fc;
            border:1px solid #e5e7eb;
            margin-bottom:10px;
        }
        .name{
            font-weight:900;
            color:#111827;
            font-size:14px;
        }
        .date{
            font-size:12px;
            color:#6b7280;
            font-weight:800;
            white-space:nowrap;
        }
        .empty{
            padding:14px;
            border-radius:18px;
            background:#fff7ed;
            border:1px solid #fed7aa;
            color:#9a3412;
            font-weight:800;
            font-size:13px;
        }
        .btn{
            display:inline-block;
            margin-top:12px;
            text-decoration:none;
            background:#4e73df;
            color:white;
            font-weight:900;
            font-size:13px;
            padding:10px 12px;
            border-radius:16px;
        }
        .btn:hover{ background:#2e59d9; }
    </style>
</head>
<body>
<div class="card">
    <h1>Completion history</h1>
    <p class="sub">Completed courses are recorded here.</p>

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