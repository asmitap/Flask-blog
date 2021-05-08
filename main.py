from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
from flask_mail import Mail
from datetime import datetime
import json
import os
import math

# open config.json file
with open('config.json', 'r') as c:
    params = json.load(c)['params']

local_server = True
app = Flask(__name__)
app.secret_key = 'the-random-string'
app.config['UPLOAD_FOLDER'] = params['upload_location']
app.config.update(
    DEBUG=True,
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT=587,    MAIL_USE_SSL=False,
    MAIL_USE_TLS=True,
    MAIL_USERNAME=params['gmail_user'],
    MAIL_PASSWORD=params['gmail_password'])
mail = Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)


class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    email = db.Column(db.String(20), unique=True, nullable=False)
    phone = db.Column(db.String(20), unique=True, nullable=False)
    message = db.Column(db.String(120), unique=False, nullable=False)
    date = db.Column(db.String(120), unique=False)


class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), unique=False, nullable=False)
    subtitle = db.Column(db.String(100), unique=False, nullable=False)
    content = db.Column(db.String(120), unique=True, nullable=False)
    slug = db.Column(db.String(20), unique=True, nullable=False)
    posted_by = db.Column(db.String(20), unique=False, nullable=False)
    date = db.Column(db.String(12), unique=False)
    img_name = db.Column(db.String(12), unique=False)


@app.route('/dashboards', methods=['GET', 'POST'])
def dashboard():
    # if user already login
    if 'user_gmail' in session and session['user_gmail'] == params["login_email"]:
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)
    if request.method == 'POST':
        # redirect to admin panel
        user_gmail = request.form.get('gmail')
        user_pass = request.form.get('password')
        if user_gmail == params["login_email"] and user_pass == params["login_password"]:
            # set the session
            session['user_gmail'] = user_gmail
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, post=posts)
    return render_template('login.html', params=params)


@app.route('/')
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    page = request.args.get('page')
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]
    if page == 1:
        prev = '#'
        next = "/?page=" + str(page+1)
    elif page==last:
        prev = "/?page" + str(page-1)
        next = '#'
    else:
        prev = "/?page" + str(page-1)
        next = "/?page=" + str(page+1)

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)


@app.route('/about')
def about():
    return render_template('about.html', params=params)


# @app.route('/post')
# def post():
#     return render_template('post.html')


@app.route('/post/<string:post_slug>', methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


@app.route('/edit/<string:sno>', methods=['POST', 'GET'])
def edit(sno):
    if 'user_gmail' in session and session['user_gmail'] == params["login_email"]:
        if request.method == 'POST':
            req_title = request.form.get('title')
            subtitle = request.form.get('subtitle')
            content = request.form.get('content')
            slug = request.form.get('slug')
            img_name = request.form.get('img_name')
            posted_by = request.form.get('posted_by')
            date = datetime.now()
            if sno == '0':
                post = Posts(title=req_title, subtitle=subtitle, content=content, slug=slug, img_name=img_name, posted_by=posted_by, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = req_title
                post.subtitle = subtitle
                post.content = content
                post.slug = slug
                post.img_name = img_name
                post.posted_by = posted_by
                post.date = date
                db.session.commit()
                return redirect('/edit/'+sno)

        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post)


@app.route('/uploader', methods=['POST', 'GET'])
def uploader():
    if 'user_gmail' in session and session['user_gmail'] == params["login_email"]:
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "uploaded successfully"


@app.route('/logout')
def logout():
    session.pop('user_gmail', None)
    return redirect('/dashboards')


@app.route('/delete/<string:sno>', methods=['POST', 'GET'])
def delete(sno):
    if 'user_gmail' in session and session['user_gmail'] == params["login_email"]:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboards')


@app.route('/contact', methods=['POST', 'GET'])
def contact():
    if request.method == 'POST':
        '''Add entry to the database input from form from name attribute'''
        names = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        message = request.form['message']
        '''enter data to database'''

        entry = Contacts(name=names, email=email, phone=phone, message=message, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message('new title from ' + names,
                          sender=email,
                          recipients=[params['gmail_user']],
                          body=message + '\n' + phone
                          )
    return render_template('contact.html', params=params)


app.run(debug=True)
