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
        }

        .btn-back:hover {
            background-color: #f8fafc;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .card h2 {
            font-size: 18px;
            color: #24528d;
            margin-top: 0;
            margin-bottom: 16px;
        }

        .row {
            display: flex;
            gap: 15px;
        }

        .input-group {
            flex: 1;
        }

        .input-group label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            font-weight: 600;
        }

        input[type="text"],
        input[type="datetime-local"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #d1d9e0;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn {
            padding: 10px 25px;
            border-radius: 6px;
            cursor: pointer;
            border: none;
            font-weight: 600;
        }

        .btn-set {
            background: #5a965e;
            color: white;
            margin-top: 15px;
        }

        .btn-mark {
            background: #4a81bd;
            color: white;
        }

        .btn-reset {
            background: #db4437;
            color: white;
            margin-top: 12px;
        }

        .progress-text {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .progress-bar-bg {
            background-color: #e0e4e8;
            height: 24px;
            border-radius: 6px;
            overflow: hidden;
            margin-top: 15px;
        }

        .progress-bar-fill {
            background: linear-gradient(90deg, #5ba360, #76c77a);
            height: 100%;
            width: 0%;
            transition: width 0.8s ease-in-out;
        }

        .countdown-box {
            margin-top: 16px;
            background: #eef6ff;
            border: 1px solid #cfe0ff;
            padding: 12px 14px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            color: #24528d;
        }

        .reward-box {
            background-color: #fff9e6;
            border: 1px solid #ffeeba;
            padding: 15px;
            border-radius: 8px;
        }

        .reward-box.unlocked {
            background-color: #e6f4ea;
            border-color: #ceead6;
        }

        .reward-box.expired {
            background-color: #fef2f2;
            border-color: #fecaca;
        }

        .message-success {
            background: #ecfdf5;
            color: #166534;
            border: 1px solid #bbf7d0;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 18px;
            font-weight: 700;
        }

        .message-error {
            background: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 18px;
            font-weight: 700;
        }

        .message-achievement {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 18px;
            font-weight: 700;
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
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <a href="/dashboard" class="btn-back">← Dashboard</a>
        <span style="font-size:32px;">🎯</span>
        <h1>Course Goal Tracker</h1>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="message-success">${successMessage}</div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="message-error">${errorMessage}</div>
    </c:if>

    <c:if test="${not empty achievementMessage}">
        <div class="message-achievement">${achievementMessage}</div>
    </c:if>

    <c:if test="${not empty expiredMessage}">
        <div class="message-error">${expiredMessage}</div>
    </c:if>

    <div class="card">
        <h2>Set Your Goal</h2>

        <form action="/updateGoal" method="POST">
            <div class="row">
                <div class="input-group">
                    <label>Goal Target (1 to 4 courses)</label>
                    <input type="text" name="target" value="${goal.target}">
                </div>

                <div class="input-group">
                    <label>Deadline</label>
                    <input type="datetime-local" name="deadline" required>
                </div>
            </div>

            <button type="submit" class="btn btn-set">Set Goal</button>
        </form>

        <c:if test="${deadlinePassed}">
            <form action="/resetGoal" method="POST">
                <button type="submit" class="btn btn-reset">Set New Goal</button>
            </form>
        </c:if>
    </div>

    <div class="card">
        <h2>Completed Courses</h2>
        <p>Your progress is automatically calculated from courses completed after this goal was set and before the deadline.</p>
        <a href="/completion" class="btn btn-mark" style="display:inline-block; text-decoration:none;">View Completion History</a>
    </div>

    <div class="card">
        <h2>Progress</h2>

        <p class="progress-text">
            ${goal.completedCount} / ${goal.target} Courses Completed
            (<span id="progressPercent">0%</span>)
        </p>

        <div class="progress-bar-bg">
            <div id="progressBar"
                 class="progress-bar-fill"
                 data-comp="${goal.completedCount}"
                 data-total="${goal.target}">
            </div>
        </div>

        <div class="countdown-box"
             id="countdownBox"
             data-deadline="${goal.deadline}">
            Goal deadline: <span id="countdownText">Calculating...</span>
        </div>
    </div>

    <div class="card">
        <h2>Reward</h2>

        <c:choose>
            <c:when test="${deadlinePassed && goal.completedCount < goal.target}">
                <div class="reward-box expired">
                    <span>⌛ <strong>Deadline Passed.</strong> Set a new goal to try again.</span>
                </div>
            </c:when>

            <c:when test="${goal.completedCount >= goal.target && goal.target > 0}">
                <div class="reward-box unlocked">
                    <span>🎉 <strong>Goal Reached!</strong> You earned <b>+50 XP</b> and may have unlocked a new badge!</span>
                </div>
            </c:when>

            <c:otherwise>
                <div class="reward-box">
                    <span>🏆 Complete your goal before the deadline to earn <b>+50 XP</b> and progress toward new badges.</span>
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

    if (pct > 100) {
        pct = 100;
    }

    bar.style.width = pct + '%';

    var percentText = document.getElementById("progressPercent");
    if (percentText) {
        percentText.innerText = Math.round(pct) + "%";
    }

    var countdownBox = document.getElementById("countdownBox");
    var countdownText = document.getElementById("countdownText");

    function startCountdown() {
        if (!countdownBox || !countdownText) {
            return;
        }

        var deadlineRaw = countdownBox.getAttribute("data-deadline");

        if (!deadlineRaw) {
            countdownText.innerText = "Unavailable";
            return;
        }

        var deadline = new Date(deadlineRaw);

        if (isNaN(deadline.getTime())) {
            countdownText.innerText = "Unavailable";
            return;
        }

        function updateCountdown() {
            var now = new Date();
            var diff = deadline.getTime() - now.getTime();

            if (diff <= 0) {
                countdownText.innerText = "Time expired";
                return;
            }

            var totalSeconds = Math.floor(diff / 1000);
            var days = Math.floor(totalSeconds / (60 * 60 * 24));
            var hours = Math.floor((totalSeconds % (60 * 60 * 24)) / (60 * 60));
            var minutes = Math.floor((totalSeconds % (60 * 60)) / 60);
            var seconds = totalSeconds % 60;

            countdownText.innerText =
                days + "d " + hours + "h " + minutes + "m " + seconds + "s";
        }

        updateCountdown();
        setInterval(updateCountdown, 1000);
    }

    startCountdown();
</script>

</body>
</html>