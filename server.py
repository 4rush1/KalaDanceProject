from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return "<h1>Hello World</h1>"

@app.route('/beginnerinfo')
def BeginnerInfo():
    return "<h1>Beginner Info</h1>"

@app.route('/newsevents')
def NewsEvents():
    return "<h1>News/Events</h1>"

@app.route('/enrol')
def enrol():
    return "<h1>Enrol</h1>"

if __name__ == "__main__":
    app.run(debug=True)