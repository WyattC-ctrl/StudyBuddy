from flask_sqlalchemy import SQLAlchemy
import datetime
import base64

db = SQLAlchemy()

profile_course_association = db.Table(
    "profile_courses",
    db.Column("profile_id", db.Integer, db.ForeignKey("profiles.id"), primary_key=True),
    db.Column("course_id", db.Integer, db.ForeignKey("courses.id"), primary_key=True),
)

profile_studytime_association = db.Table(
    "profile_study_times",
    db.Column("profile_id", db.Integer, db.ForeignKey("profiles.id"), primary_key=True),
    db.Column("study_time_id", db.Integer, db.ForeignKey("study_times.id"), primary_key=True),
)

profile_major_association = db.Table(
    "profile_majors",
    db.Column("profile_id", db.Integer, db.ForeignKey("profiles.id"), primary_key=True),
    db.Column("major_id", db.Integer, db.ForeignKey("majors.id"), primary_key=True),
)

profile_minor_association = db.Table(
    "profile_minors",
    db.Column("profile_id", db.Integer, db.ForeignKey("profiles.id"), primary_key=True),
    db.Column("minor_id", db.Integer, db.ForeignKey("minors.id"), primary_key=True),
)

class User(db.Model):
   """
   Depicts a User.
   A user has one profile.
   """
   __tablename__ = "users"
   id = db.Column(db.Integer, primary_key=True)
   username = db.Column(db.String(100), nullable=False)
   email = db.Column(db.String(100), nullable=False)
   password = db.Column(db.String(100), nullable=False)
   profile = db.relationship("Profile", back_populates="user", uselist=False)
   
   def __init__(self, **kwargs):
      """
      Initializes a User.
      """
      self.username = kwargs.get("username", "")
      self.email = kwargs.get("email", "")
      self.password = kwargs.get("password", "")
      
   def serialize(self):
      """
      Serializes a User into a dictionary, providing all their information.
      """
      return {
         "id": self.id,
         "username": self.username,
         "email": self.email,
         "profile": self.profile.simple_serialize() if self.profile else None,
      }

class Profile(db.Model):
   """
   Depicts a Profile.
   A profile can be linked to many courses.
   A profile links to one study area.
   A profile can have multiple study times.
   A profile can have multiple majors.
   A profile can have multiple minors.
   A profile can have one college.
   """
   __tablename__ = "profiles"
   id = db.Column(db.Integer, primary_key=True)
   user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False, unique=True)
   study_area_id = db.Column(db.Integer, db.ForeignKey("study_areas.id"), nullable=True)
   name = db.Column(db.String(255), nullable=False)
   college_id = db.Column(db.Integer, db.ForeignKey("colleges.id"), nullable=True)
   profile_image_blob = db.Column(db.LargeBinary, nullable=True)
   profile_image_mime = db.Column(db.String(100), nullable=True)
   study_area = db.relationship("StudyArea", back_populates="profiles", uselist=False)
   study_times = db.relationship("StudyTime", secondary=profile_studytime_association, back_populates="profiles")
   courses = db.relationship("Course", secondary=profile_course_association, back_populates="profiles")
   majors = db.relationship("Major", secondary=profile_major_association, back_populates="profiles")
   minors = db.relationship("Minor", secondary=profile_minor_association, back_populates="profiles")
   college = db.relationship("College", back_populates="profiles", uselist=False)
   user = db.relationship("User", back_populates="profile", uselist=False)
   
   def __init__(self, **kwargs):
      """
      Initializes a Profile.
      """
      self.user_id = kwargs.get("user_id")
      self.study_area_id = kwargs.get("study_area_id")
      self.name = kwargs.get("name", "")
      self.college_id = kwargs.get("college_id")
      self.profile_image_blob = kwargs.get("profile_image_blob")
      self.profile_image_mime = kwargs.get("profile_image_mime")
      self.study_area = kwargs.get("study_area")
      self.study_times = kwargs.get("study_times", [])
      self.courses = kwargs.get("courses", [])
      self.majors = kwargs.get("majors", [])
      self.minors = kwargs.get("minors", [])
      self.college = kwargs.get("college")

   def serialize(self):
      """
      Serializes a Profile, including related objects.
      """
      encoded_blob = None
      if self.profile_image_blob:
         encoded_blob = base64.b64encode(self.profile_image_blob).decode("utf-8")
      return {
         "id": self.id,
         "user_id": self.user_id,
         "name": self.name,
         "has_profile_image_blob": self.profile_image_blob is not None,
         "profile_image_blob_url": f"/profiles/{self.id}/image/" if self.profile_image_blob else None,
         "profile_image_blob_base64": encoded_blob,
         "profile_image_mime": self.profile_image_mime,
         "study_area": self.study_area.simple_serialize() if self.study_area else None,
         "study_times": [st.simple_serialize() for st in self.study_times],
         "courses": [c.simple_serialize() for c in self.courses],
         "majors": [m.simple_serialize() for m in self.majors],
         "minors": [m.simple_serialize() for m in self.minors],
         "college": self.college.simple_serialize() if self.college else None,
      }

   def simple_serialize(self):
      """
      Serializes a Profile without nested relationships.
      """
      return {
         "id": self.id,
         "user_id": self.user_id,
         "name": self.name,
         "study_area_id": self.study_area_id,
         "college_id": self.college_id,
         "has_profile_image_blob": self.profile_image_blob is not None,
         "profile_image_mime": self.profile_image_mime,
      }
   
   
class Course(db.Model):
   """
   Depicts a Course.
   A course can be linked to many profiles.
   """
   __tablename__ = "courses"
   id = db.Column(db.Integer, primary_key=True)
   code = db.Column(db.String(100), nullable=False)
   profiles = db.relationship("Profile", secondary=profile_course_association, back_populates="courses")

   def __init__(self, **kwargs):
      """
      Initializes a Course.
      """
      self.code = kwargs.get("code", "")

   def serialize(self):
      """
      Serializes a Course, including related profiles.
      """
      return {
         "id": self.id,
         "code": self.code,
         "profiles": [p.simple_serialize() for p in self.profiles],
      }

   def simple_serialize(self):
      """
      Serializes a Course without relationships.
      """
      return {
         "id": self.id,
         "code": self.code,
      }

class StudyArea(db.Model):
   """
   Depicts a favorite study area.
   A study area can be linked to many profiles.
   """
   __tablename__ = "study_areas"
   id = db.Column(db.Integer, primary_key=True)
   name = db.Column(db.String(255), nullable=False)
   profiles = db.relationship("Profile", back_populates="study_area")

   def __init__(self, **kwargs):
      """
      Initializes a StudyArea.
      """
      self.name = kwargs.get("name", "")

   def serialize(self):
      """
      Serializes a StudyArea, including related profiles.
      """
      return {
         "id": self.id,
         "name": self.name,
         "profiles": [p.simple_serialize() for p in self.profiles],
      }

   def simple_serialize(self):
      """
      Serializes a StudyArea without relationships.
      """
      return {
         "id": self.id,
         "name": self.name,
      }

class StudyTime(db.Model):
   """
   Depicts a study time option (e.g., morning, afternoon, evening).
   A study time can be linked to many profiles.
   """
   __tablename__ = "study_times"
   id = db.Column(db.Integer, primary_key=True)
   name = db.Column(db.String(50), nullable=False, unique=True)
   profiles = db.relationship("Profile", secondary=profile_studytime_association, back_populates="study_times")

   def __init__(self, **kwargs):
      """
      Initializes a StudyTime.
      """
      self.name = kwargs.get("name", "")

   def serialize(self):
      """
      Serializes a StudyTime, including related profiles.
      """
      return {
         "id": self.id,
         "name": self.name,
         "profiles": [p.simple_serialize() for p in self.profiles],
      }

   def simple_serialize(self):
      """
      Serializes a StudyTime without relationships.
      """
      return {
         "id": self.id,
         "name": self.name,
      }

class Major(db.Model):
   """
   Depicts a Major.
   A major can be linked to many profiles.
   """
   __tablename__ = "majors"
   id = db.Column(db.Integer, primary_key=True)
   name = db.Column(db.String(255), nullable=False, unique=True)
   profiles = db.relationship("Profile", secondary=profile_major_association, back_populates="majors")

   def __init__(self, **kwargs):
      """
      Initializes a Major.
      """
      self.name = kwargs.get("name", "")

   def serialize(self):
      """
      Serializes a Major, including related profiles.
      """
      return {
         "id": self.id,
         "name": self.name,
         "profiles": [p.simple_serialize() for p in self.profiles],
      }

   def simple_serialize(self):
      """
      Serializes a Major without relationships.
      """
      return {
         "id": self.id,
         "name": self.name,
      }


class Minor(db.Model):
   """
   Depicts a Minor.
   A minor can be linked to many profiles.
   """
   __tablename__ = "minors"
   id = db.Column(db.Integer, primary_key=True)
   name = db.Column(db.String(255), nullable=False, unique=True)
   profiles = db.relationship("Profile", secondary=profile_minor_association, back_populates="minors")

   def __init__(self, **kwargs):
      """
      Initializes a Minor.
      """
      self.name = kwargs.get("name", "")

   def serialize(self):
      """
      Serializes a Minor, including related profiles.
      """
      return {
         "id": self.id,
         "name": self.name,
         "profiles": [p.simple_serialize() for p in self.profiles],
      }

   def simple_serialize(self):
      """
      Serializes a Minor without relationships.
      """
      return {
         "id": self.id,
         "name": self.name,
      }


class College(db.Model):
   """
   Depicts a College.
   A college can be linked to many profiles.
   """
   __tablename__ = "colleges"
   id = db.Column(db.Integer, primary_key=True)
   name = db.Column(db.String(255), nullable=False, unique=True)
   profiles = db.relationship("Profile", back_populates="college")

   def __init__(self, **kwargs):
      """
      Initializes a College.
      """
      self.name = kwargs.get("name", "")

   def serialize(self):
      """
      Serializes a College, including related profiles.
      """
      return {
         "id": self.id,
         "name": self.name,
         "profiles": [p.simple_serialize() for p in self.profiles],
      }

   def simple_serialize(self):
      """
      Serializes a College without relationships.
      """
      return {
         "id": self.id,
         "name": self.name,
      }
   

class Message(db.Model):
   """
   Depicts a private message between two users.
   """
   __tablename__ = "messages"
   id = db.Column(db.Integer, primary_key=True)
   sender_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
   receiver_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
   content = db.Column(db.String(5000), nullable=False)
   timestamp = db.Column(db.DateTime, default=db.func.current_timestamp())

   sender = db.relationship("User", foreign_keys=[sender_id], backref="sent_messages")
   receiver = db.relationship("User", foreign_keys=[receiver_id], backref="received_messages")

   def __init__(self, **kwargs):
      """
      Initializes a Message.
      """
      self.sender_id = kwargs.get("sender_id")
      self.receiver_id = kwargs.get("receiver_id")
      self.content = kwargs.get("content", "")

   def serialize(self):
      """
      Serializes a Message.
      """
      return {
         "id": self.id,
         "sender_id": self.sender_id,
         "receiver_id": self.receiver_id,
         "content": self.content,
         # Format the timestamp for readability
         "timestamp": self.timestamp.strftime("%Y-%m-%d %H:%M:%S") if self.timestamp else None
      }
   

   
class Meeting(db.Model): # ADDED NEW MODEL
   """
   Depicts a scheduled meeting between two users.
   """
   __tablename__ = "meetings"
   id = db.Column(db.Integer, primary_key=True)
   user1_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
   user2_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
   time = db.Column(db.DateTime, nullable=False)
   location = db.Column(db.String(255), nullable=True)
   description = db.Column(db.String(1000), nullable=True)
   
   # Relationships to link users (using foreign_keys to distinguish user roles)
   user1 = db.relationship("User", foreign_keys=[user1_id], backref="meetings_as_user1")
   user2 = db.relationship("User", foreign_keys=[user2_id], backref="meetings_as_user2")

   def __init__(self, **kwargs):
      """
      Initializes a Meeting.
      """
      self.user1_id = kwargs.get("user1_id")
      self.user2_id = kwargs.get("user2_id")
      # Expecting 'time' as a datetime object or string that can be parsed
      self.time = kwargs.get("time") 
      self.location = kwargs.get("location")
      self.description = kwargs.get("description")

   def serialize(self):
      """
      Serializes a Meeting.
      """
      return {
         "id": self.id,
         "user1_id": self.user1_id,
         "user2_id": self.user2_id,
         "time": self.time.isoformat() if self.time else None, # Use ISO format for standard time representation
         "location": self.location,
         "description": self.description,
      }
   

class UserMatchStatus(db.Model):
    """
    Records a unidirectional swipe/action (LIKE or DISLIKE) from one user to another.
    """
    __tablename__ = 'user_match_status'
    
    id = db.Column(db.Integer, primary_key=True)
    
    # User who initiated the swipe/action
    swiper_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    
    # User who was swiped on/rated
    target_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    
    # Status: 'LIKE' or 'DISLIKE'
    status = db.Column(db.String(10), nullable=False) 
    
    # Optional: Prevent duplicate swipes
    __table_args__ = (
        db.UniqueConstraint('swiper_id', 'target_id', name='_swiper_target_uc'),
    )

    # Relationships to the User Table
    swiper = db.relationship("User", foreign_keys=[swiper_id], backref="swipes_made")
    target = db.relationship("User", foreign_keys=[target_id], backref="swipes_received")

    def __init__(self, swiper_id, target_id, status):
        self.swiper_id = swiper_id
        self.target_id = target_id
        self.status = status

    def serialize(self):
        return {
            "id": self.id,
            "swiper_id": self.swiper_id,
            "target_id": self.target_id,
            "status": self.status
        }

class Match(db.Model):
    """
    Represents a finalized, mutual match between two users.
    This simplifies querying for current chat partners.
    """
    __tablename__ = 'matches'
    
    id = db.Column(db.Integer, primary_key=True)
    
    # User IDs involved in the match
    user1_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    user2_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    
    # Timestamp of when the mutual match occurred
    matched_on = db.Column(db.DateTime, default=db.func.current_timestamp())

    # Constraints: Ensure the pair is unique regardless of order (e.g., (1, 2) is the same as (2, 1))
    __table_args__ = (
        db.UniqueConstraint('user1_id', 'user2_id', name='_match_pair_uc'),
        db.CheckConstraint('user1_id < user2_id', name='_check_user_order') # Enforces canonical order (e.g., user1_id must be the lower ID)
    )

    # Relationships
    user1 = db.relationship("User", foreign_keys=[user1_id], backref="matches_as_user1")
    user2 = db.relationship("User", foreign_keys=[user2_id], backref="matches_as_user2")

    def __init__(self, user1_id, user2_id):
        # Automatically ensures canonical order for the unique constraint
        self.user1_id = min(user1_id, user2_id)
        self.user2_id = max(user1_id, user2_id)

    def serialize(self):
        return {
            "id": self.id,
            "user1_id": self.user1_id,
            "user2_id": self.user2_id,
            "matched_on": self.matched_on.strftime("%Y-%m-%d %H:%M:%S")
        }
    

class UserAvailabilityDay(db.Model):
    """
    Stores a specific day a user has indicated they are available.
    """
    __tablename__ = "user_availability_days"
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    
    # Store the day as a string (e.g., 'Monday', 'Tuesday')
    # Use a string here for flexibility, as it's separate from the StudyDay model
    available_day = db.Column(db.String(50), nullable=False) 
    
    # Optional: timestamp for when they added it
    timestamp = db.Column(db.DateTime, default=db.func.current_timestamp())

    # Relationship to the User model (optional, but good practice)
    user = db.relationship("User", backref="availability_days")

    # Constraint: A user can only list a specific day once
    __table_args__ = (
        db.UniqueConstraint('user_id', 'available_day', name='_user_day_uc'),
    )

    def __init__(self, user_id, available_day):
        """
        Initializes a UserAvailabilityDay.
        """
        self.user_id = user_id
        self.available_day = available_day.strip().capitalize() # Normalize for consistency

    def serialize(self):
        """
        Serializes a UserAvailabilityDay.
        """
        return {
            "id": self.id,
            "user_id": self.user_id,
            "available_day": self.available_day,
            "timestamp": self.timestamp.strftime("%Y-%m-%d %H:%M:%S") if self.timestamp else None,
            "username": self.user.username if self.user else None
        }
    
