from flask import Flask, render_template, request, redirect, url_for
from db_function import run_search_query_tuples, run_commit_query
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


@app.route('/news_cud', methods=["GET", "POST"])
def news_cud():
    # Arrive at page from get or post method and collect data from web address
    data = request.args
    required_keys = ['id', 'task']
    for k in required_keys:
        if k not in data.keys():
            message = "do not know what to do with create, read, update on news (key not present)"
            return render_template("error.html", message=message)
# GET
    if request.method == "GET":
        if data['task'] == 'delete':
            # first query, the ? could be any number, it's an unknown variable
            sql = "delete from news where news_id = ?"
            # unknown variable declared in tuple
            values_tuple = (data['id'],)
            # tuple is passed into the result
            result = run_commit_query(sql, values_tuple, db_path)
            print("delete")
            print(result)
            # redirects us back to the news page after deleting
            return redirect(url_for('news'))
        elif data['task'] == 'update':
            sql = """ select title, subtitle, content from news where news_id=? """
            values_tuple = (data['id'],)
            result = run_search_query_tuples(sql, values_tuple, db_path, True)
            # comes back in a list, just wants the first value
            result = result[0]
            return render_template("news_cud.html",
                                   **result,
                                   id=data['id'],
                                   task=data['task'])
        elif data['task'] == 'add':
            temp = {'title':'test title', 'subtitle':'test subtitle', 'content':'test content'}
            return render_template("news_cud.html",
                                   id=0,
                                   task=data['task'],
                                   **temp)
        else:
            message = "Unrecognised task coming from news page"
            return render_template("error.html", message=message)
# POST
    elif request.method == "POST":
        # collected form info
        f = request.form
        print(f)
        if data['task'] == 'add':
            # add the new news entry to the database
            # could be different title, subtitle and content each time --> ???
            # the datetime now is a sqlite command --> gets time off server and add it in SQLite format
            # member is fixed at 2 for now, but will change later depending on who is logged in
            sql = """insert into news(title, subtitle, content, newsdate, member_id)
                        values(?,?,?, datetime('now', 'localtime'),2)"""
            # tuple values
            values_tuple = (f['title'], f['title'], f['content'])
            result = run_commit_query(sql, values_tuple, db_path)
            return redirect(url_for('news'))
        elif data['task'] == 'update':
            sql = """update news set title=?, subtitle=?, content=?, newsdate=datetime('now', 'localtime') where news_id=?"""
            # tuple values
            values_tuple = (f['title'], f['subtitle'], f['content'], data['id'])
            result = run_commit_query(sql, values_tuple, db_path)
            # collect the data from the form and update the database to the sent id
            return redirect(url_for('news'))
    return render_template("news_cud.html")

@app.route('/signup', methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        f = request.form
        print(f)
        return render_template("confirm.html", signup_data=f)

    elif request.method == "GET":
        temp_form_data={
            "firstname" : "Janet",
            "surname" : "Jackson",
            "email" : "jj@gmail.com",
            "selgroup" : "",
            "aboutme" : "I am a good dancer",
        }
        return render_template("signup.html", **temp_form_data)

@app.route('/classes')
def classes():

    sql = """ select c.class_id, c.class_title, c.class_subtitle, c.class_description
     from classes c
     order by c.class_title desc;
     """

    result = run_search_query_tuples(sql, (), db_path, True)
    print(result)

    return render_template("classes.html", classes=result)

@app.route('/registrations')
def registrations():
    data = request.args
    sql = """ select m.member_id, m.firstname, m.age_group, c.class_title
            from member m
            join registration r on m.member_id = r.member_id
            join classes c on r.class_id = c.class_id
            where c.class_id = ?
            order by m.age_group desc;
            """
    values_tuple=(data['class_id'],)
    result = run_search_query_tuples(sql, values_tuple, db_path, True)
    return render_template("register.html", register=result)


if __name__ == "__main__":
    app.run(debug=True)