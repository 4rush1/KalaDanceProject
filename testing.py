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


if __name__ == "__main__":
    db_path = 'data/dance_db.sqlite'
    # get_news(db_path)
    # get_classes(db_path)
    registration(db_path)