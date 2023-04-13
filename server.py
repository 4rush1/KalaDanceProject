from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/beginnerinfo')
def BeginnerInfo():
    return render_template("beginner_info.html")

@app.route('/newsevents')
def NewsEvents():
    return render_template("news_events.html")

@app.route('/enrol', methods=["GET", "POST"])
def enrol():
    return render_template("enrol.html")

if __name__ == "__main__":
    app.run(debug=True)