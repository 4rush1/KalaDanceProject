from flask import Flask, render_template, request, redirect, url_for
from db_function import run_search_query_tuples
from datetime import datetime

app = Flask(__name__)
db_path = 'data/dance_db.sqlite'

#format of date, year, month, day, hour, minute, second
#string format time
@app.template_filter()
def news_date(sqlite_dt):
    x = datetime.strptime(sqlite_dt, '%Y-%m-%d %H:%M:%S')
    return x.strftime('%a-%d-%b %y %I:%M %p')

@app.route('/')
def index():
    return render_template("index.html")


@app.route('/initialinfo')
def BeginnerInfo():
    return render_template("initial_info.html")


@app.route('/news')
def news():
    # query for the news page
    sql = """ select news.news_id, news.title, news.subtitle, news.content, news.newsdate, member.firstname 
    from news 
    join member on news.member_id = member.member_id
    order by news.newsdate desc;
    """
    result = run_search_query_tuples(sql, (), db_path, True)
    print(result)
    return render_template("news.html", news=result)


@app.route('/news_cud')
def news_cud():
    # Arrive at page from get or post method and collect data from web address
    data = request.args
    required_keys = ['id', 'task']
    for k in required_keys:
        if k not in data.keys():
            message = "do not know what to do with create, read, update on news (key not present)"
            return render_template("error.html", message=message)
    if request.method == "GET":
        if data['task'] == 'delete':
            return "<h1>I want to delete</h1>"
        elif data['task'] == 'update':
            return "<h1>I want to update</h1>"
        elif data['task'] == 'add':
            return "<h1>I want to add news</h1>"
        else:
            message = "Unrecognised task coming from news page"
            return render_template("error.html", message=message)

    return render_template("news_cud.html")

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