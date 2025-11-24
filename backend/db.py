from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
   """
   Depicts a User.
   """
   __tablename__ = "users"
   id = db.Column(db.Integer, primary_key=True)
   name = db.Column(db.String(100), nullable=False)
   email = db.Column(db.String(100), nullable=False)
   password = db.Column(db.String(100), nullable=False)
   profile_id = db.Column(db.Integer, db.ForeignKey("profiles.id", ondelete="SET NULL"), unique=True, nullable=True)

class Profile(db.Model):
   """
   Depicts a Profile.
   """
   __tablename__ = "profiles"
   id = db.Column(db.Integer, primary_key=True)
   user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False, unique=True)
   description = db.Column(db.String(255), nullable=True)
   major = db.Column(db.String(255), nullable=True)
   studytime = ???
   courses = ???
   
class Courses(db.Model):
   """
   Depicts a Course.
   """
   id = db.Column(db.Integer, primary_key=True)
   code = db.Column(db.String(100), nullable=False)
   profiles = ???