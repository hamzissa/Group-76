const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const bcrypt = require('bcrypt');
const path = require('path');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3000;

const dbPath = path.resolve(__dirname, 'data', 'user.db');
const db = new sqlite3.Database(dbPath);

db.serialize(() => {
    db.run(`
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL UNIQUE,
            password_hash TEXT NOT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            last_login DATETIME
        )
    `);
});

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));

app.post('/register', async (req, res) => {
    const { email, password, confirm } = req.body;

    if (password !== confirm) {
        return res.send("Passwords do not match!");
    }

    try {
        const hash = await bcrypt.hash(password, 10);
        const sql = `INSERT INTO users (email, password_hash) VALUES (?, ?)`;
        
        db.run(sql, [email, hash], function(err) {
            if (err) {
                if (err.message.includes("UNIQUE")) return res.send("Email already exists!");
                return res.send("Error saving user.");
            }
            res.send("Account created successfully! <a href='/'>Login here</a>");
        });
    } catch (err) {
        res.status(500).send("Server error.");
    }
});

app.post('/login', (req, res) => {
    const { email, password } = req.body;
    const sql = `SELECT * FROM users WHERE email = ?`;

    db.get(sql, [email], async (err, user) => {
        if (err || !user) {
            return res.send("User not found.");
        }

        const match = await bcrypt.compare(password, user.password_hash);
        if (match) {
            db.run(`UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE id = ?`, [user.id]);
            res.send(`Login successful! Welcome ${user.email}`);
        } else {
            res.send("Incorrect password.");
        }
    });
});

app.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
});