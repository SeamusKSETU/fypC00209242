from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Verification(db.Model):
    email = db.Column(db.String(320), primary_key=True)
    code = db.Column(db.String(6), nullable=False)
    dtAdded = db.Column(db.DateTime, nullable=False)
    dtVerified = db.Column(db.DateTime)

    def __repr__(self):
        return f'Verififcation {self.email}: {self.code} Added: {self.dtAdded} Verified: {self.dtVerified}'

class Users(db.Model):
    id = db.Column(db.Integer, primary_key=True) #sqlalchemy sets integer primary key columns to autoincrement
    email = db.Column(db.String(320), nullable=False)
    password = db.Column(db.LargeBinary, nullable=False) #will be hashed
    deviceID = db.Column(db.String(32), nullable=False)
    dtAdded = db.Column(db.DateTime, nullable=False)
    dtVerified = db.Column(db.DateTime) #for use tracking when verified to MacTable
    presiding = db.Column(db.Boolean, nullable=False) #for user type
    registrar = db.Column(db.Boolean, nullable=False) #fpor user type
    addedBy = db.Column(db.Integer, nullable=False) #keeping track of who registered who

class MacTable(db.Model):
    deviceID = db.Column(db.String(32), primary_key=True)
    mac = db.Column(db.String(17), unique=True)
    ip = db.Column(db.String(15), unique=True)

class Candidates(db.Model):
    alphOrder = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    elected = db.Column(db.Boolean, nullable=False)
    eliminated = db.Column(db.Boolean, nullable=False)

class VoteCount(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    voteprefs = db.Column(db.String(100), nullable=False)
    scanBy = db.Column(db.Integer) #user id
    boxNo = db.Column(db.String(4), nullable=False) #would be int but post votes exist so string, leaving overhead for up to 9999
    dtTimestamp = db.Column(db.DateTime, nullable=False)

class Tally(db.Model):
    round = db.Column(db.Integer, primary_key=True)
    effectivePrefs = db.Column(db.String(100), primary_key=True)
    activePref = db.Column(db.Integer)
    nextPref = db.Column(db.Integer)
    count = db.Column(db.Integer)

class Globals(db.Model):
    #will be used for tracking various miscellaneous values - SeatCount, TotalVotesCast, Quota, CountActive
    id = db.Column(db.Integer, primary_key=True)
    globalName = db.Column(db.String, nullable=False)
    globalValue = db.Column(db.Integer)