<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Progress</title>

    <style>
        body {
            margin: 0;
            font-family: "Nunito", sans-serif;
            background: #eef2f7;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 380px;
            padding: 40px;
            background: white;
            border-radius: 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 800;
            color: #333;
        }

        .info {
            background: #f7f9fc;
            border: 1px solid #ddd;
            border-radius: 20px;
            padding: 14px 16px;
            margin-bottom: 12px;
            box-sizing: border-box;
            color: #333;
            font-size: 14px;
        }

        .label {
            font-weight: 800;
            color: #4e73df;
        }

        .progress-wrap {
            margin: 18px 0 10px;
        }

        .progress-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
            font-weight: 800;
            color: #333;
            margin-bottom: 8px;
        }

        .progress-bar {
            width: 100%;
            background: #e6ebf4;
            border-radius: 20px;
            overflow: hidden;
            height: 14px;
        }

        .progress-fill {
            height: 14px;
            border-radius: 20px;
            width: 0%;
            transition: width 0.9s cubic-bezier(.2,.9,.2,1);
        }

        .fill-in-progress { background: #4e73df; }
        .fill-paused { background: #f6c23e; }
        .fill-completed { background: #28a745; }

        button {
            width: 100%;
            padding: 16px;
            margin-top: 12px;
            border: none;
            border-radius: 20px;
            background: #4e73df;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #2e59d9;
        }

        .btn-warning {
            background: #f6c23e;
            color: #1f2937;
        }
        .btn-warning:hover {
            background: #dda20a;
        }

        .btn-success {
            background: #28a745;
        }
        .btn-success:hover {
            background: #1e7e34;
        }

        .btn-danger {
            background: #db4437;
        }
        .btn-danger:hover {
            background: #b93126;
        }

        button:disabled {
            opacity: 0.55;
            cursor: not-allowed;
        }

        .row {
            display: grid;
            grid-template-columns: 1fr;
            gap: 0;
        }

        .link {
            text-align: center;
            margin-top: 16px;
            font-size: 13px;
        }

        .link a {
            color: #4e73df;
            cursor: pointer;
            font-weight: 800;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="container">

    <h2>Course Progress</h2>

    <div class="info">
        <span class="label">Course:</span> ${progress.courseName}
    </div>

    <div class="info" id="statusBox">
        <span class="label">Status:</span> <span id="statusText">${progress.status}</span>
    </div>

    <div class="info" id="timeBox">
        <span class="label">Time Spent:</span> <span id="timeText">${progress.liveTotalSecondsSpent}</span>
    </div>

    <div class="progress-wrap">
        <div class="progress-title">
            <span>Progress</span>
            <span id="percentText">${progress.progressPercent}%</span>
        </div>

        <div class="progress-bar">
            <div id="progressFill"
                 class="progress-fill"
                 data-status="${progress.status}"
                 data-seconds="${progress.liveTotalSecondsSpent}"
                 data-estimated="${progress.estimatedTotalSeconds}"
                 data-percent="${progress.progressPercent}">
            </div>
        </div>
    </div>

    <div class="row">
        <form action="/course-progress/start" method="post">
            <button type="submit" class="btn-success">Start</button>
        </form>

        <form action="/course-progress/pause" method="post">
            <button type="submit" class="btn-warning">Pause</button>
        </form>

        <form action="/course-progress/resume" method="post">
            <button type="submit">Resume</button>
        </form>

        <form action="/course-progress/complete" method="post">
            <button type="submit" class="btn-danger">Complete</button>
        </form>
    </div>

    <div class="link">
        <a href="/dashboard">Back to Dashboard</a>
    </div>

</div>

<script>
    window.addEventListener("load", () => {
        const fill = document.getElementById("progressFill");
        const percentText = document.getElementById("percentText");
        const timeText = document.getElementById("timeText");
        const statusText = document.getElementById("statusText");

        if (!fill || !percentText || !timeText || !statusText) return;

        let status = (fill.getAttribute("data-status") || "").toUpperCase();
        let seconds = parseInt(fill.getAttribute("data-seconds") || "0", 10);
        const estimated = Math.max(parseInt(fill.getAttribute("data-estimated") || "1", 10), 1);

        function friendlyStatus(s) {
            if (s === "IN_PROGRESS") return "In Progress";
            if (s === "NOT_STARTED") return "Not Started";
            if (s === "PAUSED") return "Paused";
            if (s === "COMPLETED") return "Completed";
            return s;
        }

        function formatMMSS(totalSeconds) {
            const m = Math.floor(totalSeconds / 60);
            const s = totalSeconds % 60;
            return String(m).padStart(2, "0") + ":" + String(s).padStart(2, "0");
        }

        function calcPercent(totalSeconds) {
            const p = Math.round((totalSeconds / estimated) * 100);
            return Math.max(0, Math.min(100, p));
        }

        function applyFillColor(s) {
            fill.classList.remove("fill-in-progress", "fill-paused", "fill-completed");
            if (s === "COMPLETED") fill.classList.add("fill-completed");
            else if (s === "PAUSED") fill.classList.add("fill-paused");
            else fill.classList.add("fill-in-progress");
        }

        function render() {
            const p = calcPercent(seconds);
            percentText.textContent = p + "%";
            timeText.textContent = formatMMSS(seconds);
            fill.style.width = "0%";
            setTimeout(() => {
                fill.style.width = p + "%";
            }, 50);
        }

        statusText.textContent = friendlyStatus(status);
        applyFillColor(status);
        render();

        const startBtn = document.querySelector('form[action="/course-progress/start"] button');
        const pauseBtn = document.querySelector('form[action="/course-progress/pause"] button');
        const resumeBtn = document.querySelector('form[action="/course-progress/resume"] button');
        const completeBtn = document.querySelector('form[action="/course-progress/complete"] button');

        function applyButtonRules(s) {
            if (!startBtn || !pauseBtn || !resumeBtn || !completeBtn) return;

            startBtn.disabled = false;
            pauseBtn.disabled = false;
            resumeBtn.disabled = false;
            completeBtn.disabled = false;

            if (s === "NOT_STARTED") {
                pauseBtn.disabled = true;
                resumeBtn.disabled = true;
                completeBtn.disabled = true;
            } else if (s === "IN_PROGRESS") {
                startBtn.disabled = true;
                resumeBtn.disabled = true;
            } else if (s === "PAUSED") {
                startBtn.disabled = true;
                pauseBtn.disabled = true;
            } else if (s === "COMPLETED") {
                startBtn.disabled = true;
                pauseBtn.disabled = true;
                resumeBtn.disabled = true;
                completeBtn.disabled = true;
            }
        }

        applyButtonRules(status);

        if (status === "IN_PROGRESS") {
            setInterval(() => {
                seconds++;
                const p = calcPercent(seconds);
                percentText.textContent = p + "%";
                timeText.textContent = formatMMSS(seconds);
                fill.style.width = p + "%";
            }, 1000);
        }
    });
</script>

</body>
</html>