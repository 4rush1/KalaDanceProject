from flask import Flask, render_template, request, redirect, url_for
from db_function import run_search_query_tuples, run_commit_query
from datetime import datetime
app = Flask(__name__)
db_path = 'data/dance_db.sqlite'


@app.route('/',  methods=["GET", "POST"])
def index():
    return render_template("index.html")


if __name__ == "__main__":
    app.run(port=8000,debug=True)