from flask import Flask, render_template, request, redirect, url_for
from db_function import run_search_query_tuples
from datetime import datetime

app = Flask(__name__)
db_path = 'data/dance_db.sqlite'


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/initialinfo')
def BeginnerInfo():
    return render_template("initial_info.html")


@app.route('/news')
def news():
    # query for the news page
    sql = """ select news.news_id, news.title, news.subtitle, news.content, news.news_date, member.firstname 
    from news 
    join member on news.member_id = member.member_id
    order by news.news_date desc;
    """
    result = run_search_query_tuples(sql, (), db_path, True)
    print(result)
    return render_template("news.html", news=result)


@app.route('/enrol', methods=["GET", "POST"])
def enrol():
    if request.method == "POST":
        f = request.form
        print(f)
        return render_template("confirm.html", enrol_data=f)

    elif request.method == "GET":
        temp_form_data={
            "firstname" : "Janet",
            "surname" : "Jackson",
            "email" : "jj@gmail.com",
            "selgroup" : "",
            "aboutme" : "I am a good dancer",
        }
        return render_template("enrol.html", **temp_form_data)


if __name__ == "__main__":
    app.run(debug=True)