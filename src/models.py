"""
Database models for the Activity Management System
"""

from sqlalchemy import Column, Integer, String, ForeignKey, Table, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()

# Association table for many-to-many relationship between activities and participants
activity_participants = Table(
    'activity_participants',
    Base.metadata,
    Column('activity_id', Integer, ForeignKey('activities.id'), primary_key=True),
    Column('participant_email', String, primary_key=True)
)


class Activity(Base):
    """Activity model representing a school activity/club"""
    __tablename__ = 'activities'

    id = Column(Integer, primary_key=True)
    name = Column(String, unique=True, nullable=False, index=True)
    description = Column(String, nullable=False)
    schedule = Column(String, nullable=False)
    max_participants = Column(Integer, nullable=False)
    
    # Relationship to participants through association table
    participants = relationship(
        'Participant',
        secondary=activity_participants,
        back_populates='activities',
        cascade='all, delete'
    )

    def to_dict(self):
        """Convert to dictionary for JSON response"""
        return {
            'id': self.id,
            'name': self.name,
            'description': self.description,
            'schedule': self.schedule,
            'max_participants': self.max_participants,
            'participants': [p.email for p in self.participants]
        }

    def __repr__(self):
        return f"<Activity(id={self.id}, name='{self.name}')>"


class Participant(Base):
    """Participant model representing a student email"""
    __tablename__ = 'participants'

    id = Column(Integer, primary_key=True)
    email = Column(String, unique=True, nullable=False, index=True)
    
    # Relationship to activities through association table
    activities = relationship(
        'Activity',
        secondary=activity_participants,
        back_populates='participants'
    )

    def __repr__(self):
        return f"<Participant(id={self.id}, email='{self.email}')>"


# Database configuration
DATABASE_URL = "sqlite:///./mergington_activities.db"

engine = create_engine(
    DATABASE_URL,
    connect_args={"check_same_thread": False}
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


def init_db():
    """Initialize the database with tables"""
    Base.metadata.create_all(bind=engine)


def get_db():
    """Dependency to get database session"""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
