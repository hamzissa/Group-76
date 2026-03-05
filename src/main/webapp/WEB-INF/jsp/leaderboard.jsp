<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Global Leaderboard</title>

    <style>

        body{
            margin:0;
            font-family:"Nunito", system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
            background:#eef2f7;
            display:flex;
            justify-content:center;
            padding:40px;
        }

        .container{
            width:700px;
            background:white;
            border-radius:25px;
            padding:30px;
            box-shadow:0 15px 40px rgba(0,0,0,0.1);
        }

        h1{
            text-align:center;
            margin-bottom:5px;
        }

        .subtitle{
            text-align:center;
            color:#666;
            margin-bottom:25px;
        }

        table{
            width:100%;
            border-collapse:collapse;
        }

        th,td{
            padding:14px;
            text-align:center;
        }

        th{
            background:#4e73df;
            color:white;
        }

        tr:nth-child(even){
            background:#f7f9fc;
        }

        .current-user{
            background:#e3f2fd !important;
            font-weight:bold;
        }

        .rank{
            font-size:18px;
        }

        .btn{
            margin-top:25px;
            text-align:center;
        }

        a{
            text-decoration:none;
            background:#4e73df;
            color:white;
            padding:12px 18px;
            border-radius:12px;
        }

        .xp-summary{
            margin-top:20px;
            text-align:center;
            color:#444;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>🌍 Global Leaderboard</h1>

    <p class="subtitle">
        Users ranked by total XP earned from course completions
    </p>

    <table>

        <tr>
            <th>Rank</th>
            <th>User</th>
            <th>XP</th>
        </tr>

        <c:forEach var="u" items="${leaderboard}" varStatus="loop">

            <tr class="${u.email == sessionScope.user.email ? 'current-user' : ''}">

                <td class="rank">

                    <c:choose>
                        <c:when test="${loop.index == 0}">🥇</c:when>
                        <c:when test="${loop.index == 1}">🥈</c:when>
                        <c:when test="${loop.index == 2}">🥉</c:when>
                        <c:otherwise>${loop.index + 1}</c:otherwise>
                    </c:choose>

                </td>

                <td>${u.email}</td>
                <td>${u.xp}</td>

            </tr>

        </c:forEach>

    </table>

    <div class="xp-summary">
        Your XP: <strong>${sessionScope.user.xp}</strong>
    </div>

    <div class="btn">
        <a href="/dashboard">Back to Dashboard</a>
    </div>

</div>

</body>
</html>