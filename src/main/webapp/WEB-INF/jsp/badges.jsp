<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Badges - IBM SkillsBuild</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        .header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 40px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .header h1 {
            color: #333;
            margin-bottom: 10px;
        }
        .xp-info {
            font-size: 18px;
            color: #667eea;
            font-weight: 600;
        }
        .section {
            margin-bottom: 40px;
        }
        .section h2 {
            color: white;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .badges-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        .badge-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .badge-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
        }
        .badge-icon {
            font-size: 60px;
            margin-bottom: 15px;
        }
        .badge-card h3 {
            color: #333;
            margin-bottom: 10px;
            font-size: 18px;
        }
        .badge-card p {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .badge-xp {
            color: #667eea;
            font-weight: 600;
            font-size: 14px;
        }
        .badge-card.earned {
            border: 3px solid #4CAF50;
        }
        .badge-card.unearned {
            opacity: 0.6;
        }
        .badge-card.unearned .badge-icon {
            filter: grayscale(100%);
        }
        .earned-badge-check {
            color: #4CAF50;
            font-weight: bold;
            margin-top: 10px;
        }
        .back-btn {
            display: inline-block;
            background: white;
            color: #667eea;
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 600;
            margin-top: 20px;
            transition: background 0.3s;
        }
        .back-btn:hover {
            background: #f0f0f0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏆 Your Badges</h1>
            <p class="xp-info">Total XP: ${user.xp}</p>
        </div>

        <c:if test="${not empty earnedBadges}">
        <div class="section">
            <h2>✅ Earned Badges</h2>
            <div class="badges-grid">
                <c:forEach var="badge" items="${earnedBadges}">
                <div class="badge-card earned">
                    <div class="badge-icon">${badge.icon}</div>
                    <h3>${badge.name}</h3>
                    <p>${badge.description}</p>
                    <div class="badge-xp">Unlocked at ${badge.requiredXp} XP</div>
                    <div class="earned-badge-check">✓ Earned</div>
                </div>
                </c:forEach>
            </div>
        </div>
        </c:if>

        <c:if test="${not empty unearnedBadges}">
        <div class="section">
            <h2>🔒 Locked Badges</h2>
            <div class="badges-grid">
                <c:forEach var="badge" items="${unearnedBadges}">
                <div class="badge-card unearned">
                    <div class="badge-icon">${badge.icon}</div>
                    <h3>${badge.name}</h3>
                    <p>${badge.description}</p>
                    <div class="badge-xp">Unlock at ${badge.requiredXp} XP</div>
                </div>
                </c:forEach>
            </div>
        </div>
        </c:if>

        <a href="/dashboard" class="back-btn">← Back to Dashboard</a>
    </div>
</body>
</html>
