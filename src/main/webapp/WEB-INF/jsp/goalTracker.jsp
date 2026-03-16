<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Goal Tracker</title>
    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            display: flex;
            justify-content: center;
            padding: 40px;
            color: #334e68;
        }

        .container {
            width: 100%;
            max-width: 900px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            position: relative;
        }

        .header h1 {
            color: #24528d;
            margin: 0;
            font-size: 28px;
        }

        .btn-back {
            position: absolute;
            left: 0;
            text-decoration: none;
            background-color: white;
            color: #4a81bd;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            border: 1px solid #d1d9e0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            transition: all 0.2s;
        }

        .btn-back:hover {
            background-color: #f8fafc;
            border-color: #4a81bd;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            border: 1px solid #e1e8ed;
        }

        .card h2 {
            font-size: 18px;
            color: #24528d;
            margin-top: 0;
            margin-bottom: 20px;
            border-bottom: 1px solid #f0f4f8;
            padding-bottom: 10px;
        }

        .row {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: nowrap;
        }

        .input-group {
            display: flex;
            align-items: center;
            gap: 10px;
            flex: 1;
        }

        .input-group label {
            white-space: nowrap;
            font-size: 14px;
        }

        input[type="text"],
        select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #d1d9e0;
            border-radius: 4px;
            font-size: 14px;
            background-color: #fff;
        }

        .btn {
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.2s;
        }

        .btn-set {
            background: linear-gradient(to bottom, #76b07a, #5a965e);
            color: white;
            display: block;
            margin: 20px auto 0;
            min-width: 150px;
        }

        .btn-mark {
            background-color: #4a81bd;
            color: white;
            white-space: nowrap;
        }

        .progress-bar-bg {
            background-color: #e0e4e8;
            height: 24px;
            border-radius: 6px;
            overflow: hidden;
            margin-top: 15px;
        }

        .progress-bar-fill {
            background-color: #5ba360;
            height: 100%;
            width: 0%;
            transition: width 0.8s ease-in-out;
        }

        .reward-box {
            background-color: #fff9e6;
            border: 1px solid #ffeeba;
            padding: 15px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 15px;
        }

        .reward-box.unlocked {
            background-color: #e6f4ea;
            border-color: #ceead6;
        }
        
        .nav-links {
            margin-top: 20px;
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        
        .nav-links a {
            text-decoration: none;
            color: #4a81bd;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <a href="/dashboard" class="btn-back">← Dashboard</a>
            <span style="font-size: 32px;">🎯</span>
            <h1>Course Goal Tracker</h1>
        </div>

        <div class="card">
            <h2>Set Your Goal</h2>
            <form action="/updateGoal" method="POST">
                <div class="row">
                    <div class="input-group">
                        <label>Goal Target:</label>
                        <input type="text" name="target" value="${goal.target} Courses">
                    </div>
                    <div class="input-group">
                        <label>Timeframe:</label>
                        <select name="timeframe">
                            <option value="In One Day" ${goal.timeframe == 'In One Day' ? 'selected' : ''}>In One Day</option>
                            <option value="In One Week" ${goal.timeframe == 'In One Week' ? 'selected' : ''}>In One Week</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label>Reward:</label>
                        <input type="text" name="reward" value="Badge">
                    </div>
                </div>
                <button type="submit" class="btn btn-set">Set Goal</button>
            </form>
        </div>

        <div class="card">
            <h2>Add Completed Course</h2>
            <form action="/addCompletedItem" method="POST" class="row">
                <div class="input-group">
                    <label>Course Name:</label>
                    <input type="text" name="itemName" placeholder="Enter course name...">
                </div>
                <button type="submit" class="btn btn-mark">Mark Completed</button>
            </form>
        </div>

        <div class="card">
            <h2>Progress</h2>
            <p>${goal.completedCount} / ${goal.target} Courses Completed</p>
            <div class="progress-bar-bg">
                <div id="progressBar" class="progress-bar-fill"
                     data-comp="${goal.completedCount}"
                     data-total="${goal.target}"></div>
            </div>
        </div>

        <div class="card">
            <h2>Reward</h2>
            <c:choose>
                <c:when test="${goal.completedCount >= goal.target && goal.target > 0}">
                    <div class="reward-box unlocked">
                        <span>🎉 <strong>Goal Reached!</strong> You've unlocked: Badge</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="reward-box">
                        <span>🏆 Complete your goal to unlock your reward!</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <ul class="nav-links">
            <li><a href="/completion">View Completion History</a></li>
            <li><a href="/search">Search Courses</a></li>
            <li><a href="/leaderboard">Leaderboard</a></li>
        </ul>
    </div>

    <script>
        var bar = document.getElementById('progressBar');
        var comp = parseFloat(bar.getAttribute('data-comp')) || 0;
        var total = parseFloat(bar.getAttribute('data-total')) || 0;
        var pct = total > 0 ? (comp / total) * 100 : 0;
        bar.style.width = (pct > 100 ? 100 : pct) + '%';
    </script>
</body>
</html>