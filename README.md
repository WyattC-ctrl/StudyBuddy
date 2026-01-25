StudyBuddy Backend API
StudyBuddy is a Flask-based RESTful API designed to help students connect and form study groups. The platform allows users to create profiles, upload profile pictures directly to the database, swipe on potential partners, and schedule meetings.

Features
Authentication: Secure User Signup and Login.
Rich Profiles: Detailed student profiles including Majors, Courses, and Preferred Study Areas.
Binary Image Storage: Profile pictures are stored as BLOBs (Binary Large Objects) directly in the database for easy portability.
UserMatchStatus: Tracks "Likes" and "Dislikes" to filter suggestions.
Mutual Matches: Automatically creates a "Match" when two users like each other.
Communication: Private messaging system between users.
Scheduling: Meeting coordinator with support for locations and timestamps.

Tech Stack
Language: Python 3.x
Framework: Flask
ORM: Flask-SQLAlchemy
Database: SQLite (Development)
Data Handling: Base64 encoding for image transmission.
