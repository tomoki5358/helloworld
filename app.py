import os
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    message = os.environ.get('MESSAGE', 'helloworld')
    return message

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
