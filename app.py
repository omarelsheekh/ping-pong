from flask import Flask

app=Flask(__name__)

@app.route('/ping')
def ping():
    return "pong"

@app.route('/')
def index():
    return "Hello World"

if __name__ == "__main__":
    app.run(port=8000, host='0.0.0.0')