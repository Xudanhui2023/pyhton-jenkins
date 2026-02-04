# app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, 这是我的第一个Docker镜像!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)