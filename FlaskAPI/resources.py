from flask_restful import Resource
from flask import request
from models import *
import hashlib
import datetime


class Test(Resource):
    def get(self):
        return {'out': 'hello world'}

    def post(self):
        task_data = request.get_json()
        if not task_data:
            return {'message': 'No input data provided'}, 400
        return {'message': 'received'}

class AddVerification(Resource):
    def post(self):
        task_data = request.get_json()
        new_ver = Verification(email=task_data.get('email'),code=task_data.get('code'),dtAdded=datetime.datetime.now())
        db.session.add(new_ver)
        db.session.commit()
        return {'message': 'added'}, 200


class RegisterRegistrar(Resource):
    def post(self):
        task_data = request.get_json()
        if not task_data:
                return {'message': 'No input data provided'}, 400
        email = task_data.get('email')
        if not email:
            return {'message': 'Email is required'}, 400
        code = task_data.get('code')
        if not code:
            return {'message': 'Code is required'}, 400
        password = task_data.get('password')
        if not password:
            return {'message': 'Password is required'}, 400
        deviceID = task_data.get('deviceID')
        if not deviceID:
            return {'message': 'deviceID is required'}, 400
        action = task_data.get('action')
        if not action:
            return {'message': 'action is required'}, 400
        if action != 'register':
            return {'message': 'action must be register'}, 400
        regID = task_data.get('regID')
        if not regID:
            return {'message': 'regID is required'}, 400
        
        ver = Verification.query.filter_by(email=email).first()
        if not ver:
            return {'message': 'email not found in verified list'}, 400
        now = datetime.datetime.now()
        ver.dtVerified = now

        #just using salt as the salt for now, will have it randomly generated on setup for final versio
        pw = hashlib.pbkdf2_hmac('sha512', str.encode(password), str.encode('salt'), iterations=1000)
        new_register = Users(email=email, password=pw, deviceID=deviceID, dtAdded=now, presiding=False, registrar=True, addedBy=1) 
        #user 1 will always be presiding officer except in this demo
        db.session.add(new_register)
        db.session.commit()
        return {'message': 'registration successful'}, 200
                                        
                

