from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/beginnerinfo')
def BeginnerInfo():
    return render_template("beginner_info.html")

@app.route('/news')
def news():
    return render_template("news.html")

@app.route('/enrol', methods=["GET", "POST"])
def enrol():
    if request.method == "POST":
        f = request.form
        print(f)
        return render_template("confirmenrol.html", enrol_data=f)

    elif request.method == "GET":
        temp_form_data={
            "firstname" : "Janet",
            "surname" : "Jackson",
            "email" : "jj@gmail.com",
            "phone" : "04568765434",
            "aboutme" : "I am a good dancer",
        }
        return render_template("enrol.html", **temp_form_data)

@app.route('/signup', methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        f = request.form
        print(f)
        return render_template("confirmsignup.html", signup_data=f)

    elif request.method == "GET":
        temp_form_data_2 = {
            "firstname": "Janet",
            "surname": "Jackson",
            "email": "jj@gmail.com",
        }
        return render_template("signup.html", **temp_form_data_2)

if __name__ == "__main__":
    app.run(debug=True)