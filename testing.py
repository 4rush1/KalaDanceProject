from db_function import run_search_query_tuples

# query test #
# query for the news page #
def get_news(db_path):  # stands for path #
    sql = """ select news.title, news.subtitle, news.content, member.firstname 
    from news 
    join member on news.member_id = member.member_id;
    """
    result = run_search_query_tuples(sql, (), db_path, True)
    for row in result:
        for k in row.keys():
            print(k)
            print(row[k])


def get_classes(db_path):
    # query for the classes page
    sql = """ select classes.class_id, classes.class_title, classes.class_subtitle, classes.class_description
    from classes 
    order by classes.class_title desc;
    """
    result = run_search_query_tuples(sql, (), db_path, True)
    for d in result:
        print(d['class_title'])
        print(d['class_subtitle'])
        print(d['class_description'])

def registration(db_path):
    sql = """ select m.member_id, m.firstname, m.age_group, c.class_title
        from member m
        join registration r on m.member_id = r.member_id
        join classes c on r.class_id = c.class_id
        order by m.member_id desc;
        """
    result = run_search_query_tuples(sql, (), db_path, True)
    for d in result:
        print(d['firstname'] + d['class_title'])

def add_member(db_path):
        sql = """ select m.member_id, m.firstname, m.surname, m.age_group, c.class_title
                    from member m
                    join registration r on m.member_id = r.member_id
                    join classes c on r.class_id = c.class_id
                    where c.class_id = ?
                    order by m.age_group desc;
                    """
        values_tuple = (data['class_id'],)
        result = run_search_query_tuples(sql, values_tuple, db_path, True)
        return render_template("add_member.html", add_member=result)

    if request.method == "POST":
        # collected form info
        f = request.form
        print(f)
        if data['task'] == 'add':
            # add the new member to the class
            sql = """insert into registration(member_id, class_id)
                           values(?,?)"""
            # tuple values
            result = run_commit_query(sql, values_tuple, db_path)
            return redirect(url_for('registrations'))


        elif request.method == "POST":
            required_keys = ['member_id']
            # collected form info
            f = request.form
            print(f)
            if data['task'] == 'add':
                sql = """insert into registration(member_id, class_id)
                                values(?,?)"""
                # tuple values
                values_tuple = (f['firstname'], f['surname'], f['age_group'])
                result = run_commit_query(sql, values_tuple, db_path)
                return redirect(url_for('registration', member_id=data['member_id']))

def signup(db_path):
        # POST : TO POST INFO FROM FORM
        if request.method == "POST":
            f = request.form
            print(f)
            return render_template("confirm.html", signup_data=f)

        # GET: TO GET INFO FROM FORM
        elif request.method == "GET":
            # TEMPORARY DATA / INFO
            temp_form_data = {
                "firstname": "Janet",
                "surname": "Jackson",
                "email": "jj@gmail.com",
                "selgroup": "",
                "aboutme": "I am a good dancer",
                "password": "temp",
            }
            return render_template("signup.html", **temp_form_data)


if __name__ == "__main__":
    db_path = 'data/dance_db.sqlite'
    # get_news(db_path)
    # get_classes(db_path)
    registration(db_path)