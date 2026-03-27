# IBM SkillsBuild Course Tracker - Group 76

A gamified learning platform for tracking IBM SkillsBuild courses with XP, badges, and social features.

---

## Prerequisites

- **Java 21** or higher
- **Gradle 8.10** (or use included Gradle Wrapper)

---

## Technologies Used

- **Spring Boot 3.4.2** - Backend framework
- **Spring Data JPA / Hibernate** - Database management
- **JSP & JSTL** - Frontend views
- **H2 Database** - In-memory database
- **Gradle** - Build tool

---

## How to Run

### 1. Clone the repository
```bash
git clone https://campus.cs.le.ac.uk/gitlab/co2303_2026/Group-76.git
cd Group-76
```

### 2. Build the project
```bash
./gradlew clean build
```

### 3. Run the application
```bash
./gradlew bootRun
```

### 4. Access the application
Open your browser: `http://localhost:8080`

---

## Database Setup (H2)

### Configuration (`application.properties`)
```properties
# H2 In-Memory Database
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.username=sa
spring.datasource.password=

# Auto-create tables on startup
spring.jpa.hibernate.ddl-auto=create-drop

# H2 Console enabled
spring.h2.console.enabled=true
```

### H2 Console Access
- URL: `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:testdb`
- Username: `sa`
- Password: (leave empty)

### Initial Data
- **Default User**: `test@example.com` / `1234`
- **Badges**: 6 badges auto-loaded (Starter, Bronze, Silver, Gold, Platinum, Legend)

---

## Default Login

**Email:** `test@example.com`  
**Password:** `1234`

---

## Team Members

- Hamzah - Badge System, UI Design
- Vinay - Goal Tracker, Course Reviews
- Shamim - Popular Courses, Search
- Rayn - User Management
- George - Friends System
- Dwain - Testing

---

**Module:** CO2303 Software Engineering 2025/26  
**University of Leicester**
