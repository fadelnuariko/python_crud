from flask import Flask, render_template, flash, redirect, url_for, session, request, logging
from data import Articles
from flask_mysqldb import MySQL
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from passlib.hash import sha256_crypt
from functools import wraps

app = Flask(__name__)

# COnfig MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '123456'
app.config['MYSQL_DB'] = 'app_py'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
# ini MySQL
mysql = MySQL(app)

Articles = Articles()

#index
@app.route('/')
def index():
    return render_template('home.html')

#About
@app.route('/about')
def about():
    return render_template('about.html')

#articles
@app.route('/articles')
def articles():
    #create cur
    cur = mysql.connection.cursor()

    #get article
    result = cur.execute("SELECT * FROM articles")

    articles = cur.fetchall()

    if result > 0:
        return render_template('articles.html', articles=articles)
    else:
        msg = "No articles found"
        return render_template('articles.html', msg=msg)

    #close connection
    cur.close()

    return render_template('dashboard.html')

# Single Article
@app.route('/article/<string:id>/')
def article(id):
    #create cur
    cur = mysql.connection.cursor()

    #get article
    result = cur.execute("SELECT * FROM articles WHERE id = %s", [id])

    if result == 0:
        msg = "No articles found"
        flash('Artikel tidak ditemukan','danger')
        return render_template('article.html')
    else:
        article = cur.fetchone()
        return render_template('article.html', article=article)

    #close connection
    cur.close()

#Register form class
class RegisterForm(Form):
    name = StringField('Name', [validators.Length(min=1, max=50)])
    username = StringField('Username', [validators.Length(min=4, max=25)])
    email = StringField('Email', [validators.Length(min=6, max=50)])
    password = PasswordField('Password', [
        validators.DataRequired(),
        validators.EqualTo('confirm', message='Password tidak sama'),
    ])
    confirm = PasswordField('Confirm Password')

# Check if user logged in
def is_login(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            flash('Anda sudah login','warning')
            return redirect(url_for('dashboard'))
        else:
            return f(*args,**kwargs)

    return wrap

# User Register
@app.route('/register', methods=['GET' ,'POST'])
@is_login
def register():
    form = RegisterForm(request.form)
    if request.method == 'POST' and form.validate():
        name = form.name.data
        email = form.email.data
        username = form.username.data
        password = sha256_crypt.encrypt(str(form.password.data))

        #Create cursor
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO users(name, email, username, password) VALUES (%s, %s, %s, %s)", (name, email, username,password))

        #Commit to db
        mysql.connection.commit()

        #close
        cur.close()

        flash('You are now registered and can login','success')

        return redirect(url_for('login'))

    return render_template('register.html',form=form)

#User Login
@app.route('/login', methods=['GET','POST'])
@is_login
def login():
    if request.method=='POST':
        # get form field
        username = request.form['username']
        password_candidate = request.form['password']

        #create cursor
        cur = mysql.connection.cursor()

        #get user by username
        result = cur.execute("SELECT * FROM users WHERE username = %s", [username])

        if result > 0:
            #get stored hash
            data = cur.fetchone()
            password = data['password']

            #compare password
            if sha256_crypt.verify(password_candidate, password):
                # Passed

                session['logged_in'] = True
                session['username'] = username

                flash('You are now logged in','success')
                return redirect(url_for('dashboard'))
            else:
                error = 'Invalid Password'
                return render_template('login.html', error=error)
            # Close connection
            cur.close()
        else:
            error = 'Username not Found'
            return render_template('login.html', error=error)

    return render_template('login.html')

# Check if user logged in
def is_login(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args,**kwargs)
        else:
            flash('Unauthorize access','danger')
            return redirect(url_for('login'))
    return wrap

@app.route('/logout')
@is_login
def logout():
    session.clear()
    flash('You are now logged out','success')

    return redirect(url_for('login'))

#Dashboard
@app.route('/dashboard')
@is_login
def dashboard():

    #create cur
    cur = mysql.connection.cursor()

    #get article
    result = cur.execute("SELECT * FROM articles")

    articles = cur.fetchall()

    if result > 0:
        return render_template('dashboard.html', articles=articles)
    else:
        msg = "No articles found"
        return render_template('dashboard.html', msg=msg)

    #close connection
    cur.close()

    return render_template('dashboard.html')

#Register form class
class ArticleForm(Form):
    title = StringField('Title', [validators.Length(min=1, max=200)])
    body = TextAreaField('Username', [validators.Length(min=30)])

#Dashboard
@app.route('/add_article', methods=['GET','POST'])
@is_login
def add_article():
    form = ArticleForm(request.form)
    if request.method == 'POST' and form.validate():
        title = form.title.data
        body = form.body.data

        #create cursor
        cur = mysql.connection.cursor()

        #execute
        cur.execute("INSERT INTO articles(title, body, author) VALUES (%s, %s, %s)", (title, body, session['username']))

        #commit to db
        mysql.connection.commit()

        #close connection
        cur.close()

        flash('Artikel berhasil dibuat','success')

        return redirect(url_for('dashboard'))

    return render_template('add_article.html', form=form)

#Dashboard
@app.route('/edit_article/<string:id>', methods=['GET','POST'])
@is_login
def edit_article(id):
    # Create cursor
    cur = mysql.connection.cursor()

    # get article by id
    result = cur.execute("SELECT * FROM articles WHERE id=%s", [id])
    if result > 0:
        article = cur.fetchone()

        #Get form
        form = ArticleForm(request.form)
    else:
        flash("Artikel tidak ditemukan","danger")
        return render_template('edit_article.html')

    #populate article form fields
    form.title.data = article['title']
    form.body.data = article['body']


    if request.method == 'POST' and form.validate():
        title = request.form['title']
        body = request.form['body']

        #create cursor
        cur = mysql.connection.cursor()

        #execute
        cur.execute("UPDATE articles SET title=%s, body=%s WHERE id=%s", (title,body,id))

        #commit to db
        mysql.connection.commit()

        #close connection
        cur.close()

        flash('Artikel berhasil diupdate','success')

        return redirect(url_for('dashboard'))

    return render_template('edit_article.html', form=form)

#delete article
@app.route('/delete_article/<string:id>', methods=['POST'])
@is_login
def delete_article(id):

    #create cursor
    cur = mysql.connection.cursor()

    #execute
    cur.execute("DELETE FROM articles WHERE id =%s",[id])

    #commit to db
    mysql.connection.commit()

    #close connection
    cur.close()

    flash('Artikel berhasil dihapus','success')

    return redirect(url_for('dashboard'))

if __name__ == '__main__':
    app.secret_key='secret123'
    app.run(debug=False)
