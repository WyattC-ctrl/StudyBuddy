# StudyBuddy Backend API

**StudyBuddy** is a Flask-based RESTful API designed to help students connect and form productive study groups. The platform features a unique matching system, direct database image storage, and integrated scheduling tools.

---

##  Features

* **Secure Authentication**: robust User Signup and Login endpoints.
* **Rich Profiles**: Supports detailed student data including **Majors**, **Courses**, and **Preferred Study Areas**.
* **Binary Image Storage**: Profile pictures are stored as **BLOBs** (Binary Large Objects) directly in the database, ensuring your data is portable and contained in a single file (`app.db`).
* **UserMatchStatus**: Tracks "Likes" and "Dislikes" to curate potential partner suggestions.
* **Mutual Matches**: Automatically triggers a "Match" when two users show mutual interest.


* **Communication**: Integrated private messaging system for coordinated studying.
* **Scheduling**: Built-in meeting coordinator with support for locations and timestamps.

---

## Tech Stack

* **Language**: Python 3.x
* **Framework**: Flask
* **ORM**: Flask-SQLAlchemy
* **Database**: SQLite (Development)
* **Data Handling**: Base64 encoding for seamless image transmission via JSON.

---

## Quick Start

### 1. Set Up Virtual Environment

```bash
python3 -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

```

### 2. Install Dependencies

```bash
pip install -r requirements.txt

```

### 3. Run the Server

```bash
python3 app.py

```

*The database (`app.db`) will automatically initialize on the first launch.*

---

## Core Endpoints

### Profiles & Media

| Method | Endpoint | Description |
| --- | --- | --- |
| `POST` | `/profiles/` | Create a student profile. |
| `POST` | `/profiles/<id>/image/` | Upload a profile picture (Binary). |
| `GET` | `/profiles/<id>/image/` | Retrieve and render the profile image. |

### Social & Matching

| Method | Endpoint | Description |
| --- | --- | --- |
| `GET` | `/users/<id>/suggestions/` | Get profiles you haven't swiped on yet. |
| `POST` | `/swipes/` | Record a Like/Dislike and check for mutual matches. |
| `GET` | `/users/<id>/matches/` | View your confirmed study partners. |

---

## Project Structure

```text
StudyBuddy/
└── backend/
    ├── app.py          # Main application & Route definitions
    ├── db.py           # SQLAlchemy Models & Schema
    ├── requirements.txt# Dependencies
    ├── app.db          # SQLite Database (Auto-generated)
    └── venv/           # Virtual Environment

```
