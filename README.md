# Group 76: IBM SkillsBuild Learning Tracker

A Spring Boot web app that helps students find, start and track **IBM SkillsBuild** courses. Students register and log in, browse and search the course catalogue, time how long they spend on a course, record completed courses, and earn XP for each one they finish.

Built by Group 76 for module CO2303 at the University of Leicester.

## Features

| Feature | What it does | Route(s) |
|---|---|---|
| **Register & log in** | Create an account with email and password, then sign in. The user is stored in the HTTP session. | `GET/POST /login`, `POST /register` |
| **Dashboard** | Shows the logged-in user's email and XP, lists the IBM SkillsBuild courses, and links to the other pages. | `GET /dashboard` |
| **Start a course** | Clicking a course on the dashboard starts its progress timer and redirects to the course on IBM's site. | `GET /start-course?url=…&name=…` |
| **Course progress** | Start, pause, resume and complete the current course. A live timer and progress bar show time spent against a 1-hour estimate. | `GET /course-progress`, `POST /course-progress/{start,pause,resume,complete}` |
| **Earn XP** | Completing a course from the progress page records the completion and awards **100 XP**. | `POST /course-progress/complete` |
| **Completion history** | Lists the user's completed courses, newest first. A course can also be marked completed by name (this simulates the IBM integration). | `GET /completion`, `POST /completion/mark` |
| **Search courses** | Filters the course catalogue by keyword (case-insensitive match on the course name). | `GET/POST /search` |

All pages except login and register redirect to `/login` when nobody is logged in.

### Course catalogue

The catalogue is currently hard-coded in `DashboardController` and `SearchController`:

- Artificial Intelligence
- Data Science
- Security
- Quantum Computing

## Tech stack

- **Java 21**
- **Spring Boot 3.4.2**: Spring Web MVC and Spring Data JPA
- **JSP + JSTL** views, served by embedded Tomcat (Jasper)
- **H2** in-memory database (a MySQL connector is also on the classpath but isn't configured)
- **Gradle 8.10** through the included wrapper; the project is packaged as a WAR

## Getting started

### Prerequisites

- JDK 21
- No separate Gradle install is needed because the project includes the Gradle wrapper.

### Run the app

```bash
# macOS / Linux
./gradlew bootRun

# Windows
gradlew.bat bootRun
```

Then open <http://localhost:8080/login>.

### Test account

On startup the app creates a test user:

| Email | Password |
|---|---|
| `test@example.com` | `1234` |

The database is in memory (`jdbc:h2:mem:testdb`, `ddl-auto=create-drop`), so every restart wipes all registered users, completions and XP.

### H2 console

The H2 web console is enabled at <http://localhost:8080/h2-console>. Connect with:

- JDBC URL: `jdbc:h2:mem:testdb`
- Username: `sa`
- Password: *(leave blank)*

### Build and test

```bash
./gradlew build   # compile, run tests, and package the WAR
./gradlew test    # run tests only (JUnit 5)
```

## Project structure

```
src/main/java/com/example/group76/
├── Group76Application.java          # Entry point; creates the test user
├── controller/
│   ├── LoginController.java         # /login
│   ├── RegisterController.java      # /register
│   ├── DashboardController.java     # /dashboard and the course list
│   ├── CourseProgressController.java# /course-progress/*, /start-course, awards XP
│   ├── CompletionController.java    # /completion, /completion/mark
│   └── SearchController.java        # /search
├── model/
│   ├── User.java                    # JPA entity (users): email, password, xp
│   ├── CourseCompletion.java        # JPA entity (course_completions)
│   ├── CourseProgress.java          # In-memory timer and status state machine
│   ├── Course.java                  # Course name and URL
│   └── CourseFilter.java            # Search keyword
├── repository/
│   ├── UserRepository.java
│   └── CourseCompletionRepository.java
└── service/
    └── CourseSearchService.java     # Keyword filtering

src/main/resources/application.properties   # H2, JPA, JSP view and port config
src/main/webapp/WEB-INF/jsp/                 # login, dashboard, courseProgress, completion, searchResults
src/main/webapp/images/                      # IBM logo
data/setup.sql                               # Early draft of the users table schema (unused by the app)
```

### Course progress states

`CourseProgress` moves through these states:

```
NOT_STARTED --start--> IN_PROGRESS --pause--> PAUSED --resume--> IN_PROGRESS
                            \                    /
                             `---- complete ----'--> COMPLETED
```

Time spent builds up while the course is `IN_PROGRESS`. The progress percentage is time spent divided by the estimated 3600 seconds, capped at 100%.

## User stories

| Story | Owner | User story |
|---|---|---|
| Earn XP | Hamzah | As a student, I want to earn XP when I complete a course so that my progress feels rewarding. |
| Login and register | Dwain | As a user, I want to register and log in so that I can have a personalised experience. |
| View dashboard | George | As a student, I want to view a list of all available IBM SkillsBuild courses so that I can be directed to and start new learning courses. |
| Record completion | Rayn | As a student, I want the app to record when I complete an IBM SkillsBuild course so that I can view a history of my learning. |
| Record start times | Vinay | As a student, I want the app to record when I begin an IBM SkillsBuild course so that I can pause and resume courses. |
| Search and filter | Shamim | As a student, I want to search and filter IBM SkillsBuild courses by keywords and categories so that I can quickly find courses relevant to my interests. |

The original stories are in [`User stories`](User%20stories).

## Definition of Done

A story is done when:

1. All of its acceptance criteria are implemented.
2. It works as intended without breaking existing functionality.
3. The code is committed, reviewed and merged into `main`, and the app builds and runs without errors.
4. Relevant tests are written and pass.
5. At least one other team member has reviewed the code.

The full text is in [`Definition-of-Done.txt`](Definition-of-Done.txt).

## Known limitations

- **Missing register view:** `RegisterController` returns a `register` view, but no `register.jsp` exists. A successful registration works because it renders `login`. A failed registration (for example, passwords that don't match) tries to render the missing view and errors instead of showing the message.
- **Shared progress state:** `CourseProgressController` keeps one `CourseProgress` object for the whole app, so every logged-in user sees and controls the same timer.
- **Plain-text passwords:** passwords are stored and compared without hashing.
- **No persistence:** the H2 database is in memory and cleared on every restart.
- **No root page:** nothing is mapped to `/`, so start at `/login`.
- **Search by name only:** search matches keywords against course names. Category filtering isn't implemented yet.
- **No tests yet:** the project has no `src/test` directory.

## Team

| Name | Username |
|---|---|
| Hamzah | hi69 |
| Dwain | djt33 |
| George | gco5 |
| Rayn | rs879 |
| Vinay | vp207 |
| Shamim | sm1309 |

## Contributing

Git setup notes for the campus GitLab are in [`intelji`](intelji). In short:

1. Create a branch from `main` for your user story.
2. Commit your work and open a merge request.
3. Have at least one teammate review it before merging (see the Definition of Done).
