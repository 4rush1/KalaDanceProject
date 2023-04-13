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
    temp_form_data={
        "firstname" : "Janet",
        "surname" : "Jackson",
        "email" : "jj@gmail.com",
        "phone" : "04568765434",
        "aboutme" : "I am a good dancer",
    }
    return render_template("enrol.html", **temp_form_data)

if __name__ == "__main__":
    app.run(debug=True)