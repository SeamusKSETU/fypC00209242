from flask import Flask
from flask_restful import Api
from models import db
import config
from resources import *

app = Flask(__name__)
app.config.from_object(config)
db.init_app(app)
api = Api(app)
api.add_resource(Test, '/test')
api.add_resource(RegisterRegistrar, '/RegisterRegistrar')
api.add_resource(AddVerification, '/AddVerification')



if __name__ == '__main__':
    # Create the database tables.
    with app.app_context():
        db.create_all()
    # Start the Flask development web server.
    app.run(debug=True)