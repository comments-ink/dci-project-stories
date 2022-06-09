# dci-project-stories

It is a Django project with the following dependencies:
 * django>=4,<5
 * django-contrib-comments>=2.2,<2.3
 * djangorestframework>=3.12,<3.13
 * django-avatar>=5.0,<5.1
 * django-comments-ink>=0.0,<0.1

Features:
 * It doesn't depend on any JavaScript or UI framework.
 * It uses django-comments-ink vanilla JavaScript plugin.
 * Users and visitors can send comments and replies.
 * It uses a maximum thread level of three, which is the maximum that django-comments-ink CSS stylesheet covers. However it's a lot of threading depth. It makes difficult to follow up on every conversation thread.
 * Users can react to stories by clicking on the clapping icon displayed at the bottom of each story. Clapping is the only allowed reaction to stories. It's configured modifying the setting [`COMMENTS_INK_OBJECT_REACTIONS_ENUM`](https://github.com/comments-ink/django-comments-ink/blob/0abfbee5e02a8886f646d4bd39b3e4d89e699823/django_comments_ink/conf/defaults.py#L38).
 * Users can also send reactions to each comment. The available reactions for comments in this project are the same as the reactions for objects. Modify the setting [`COMMENTS_INK_COMMENT_REACTIONS_ENUM`](https://github.com/comments-ink/django-comments-ink/blob/0abfbee5e02a8886f646d4bd39b3e4d89e699823/django_comments_ink/conf/defaults.py#L35) to change the list of reactions available for comments.
 * django-comments-ink comes by default with a few themes that change the look of the comments. The one in the image below is the **avatar_in_header** theme, set explicitly with the setting `COMMENTS_INK_THEME_DIR`. It can take the following values, that correspond with the directories under `templates/comments/themes` in django-comments-ink:
   * `avatar_in_header`
   * `avatar_in_thread`
   * `feedback_in_header`


<p align="center"><hr /><img src="cover.png"><hr /></p>

## Run with Docker

To run the project with Docker, create an `.docker_env` file with the following vars:

    PRODUCTION=1
    SECRET_KEY="k!5lw18q1#8#&_7k=ew!k_=p%4a@)($c0b8mp_yxbvw@weng$@"
    DB_NAME=dci
    DB_USER=dci
    DB_PWD=dci
    DB_HOST=postgres
    DB_PORT=5432

And use docker compose to build the image with the Django project, launch the containers and run the migrations:

    $ docker compose build django
    $ docker compose --env-file .docker_env up -d
    $ docker compose --env-file .docker_env exec django python manage.py migrate
    $ docker compose --env-file .docker_env exec django python manage.py loaddata ../fixtures/sites.json
    $ docker compose --env-file .docker_env exec django python manage.py loaddata ../fixtures/users.json
    $ docker compose --env-file .docker_env exec django python manage.py loaddata ../fixtures/stories.json
    $ docker compose --env-file .docker_env exec django python manage.py loaddata ../fixtures/comments.json

The Django project must be running in http://localhost:9090.

## Run locally

Instead of running the project with Docker, here are the equivalent steps to setup the project locally.

### Setup virtual environment

Create a virtual environment:

    $ python3.10 -m venv venv
    $ source venv/bin/activate
    $ pip install -r requirements.txt

### Setup the Django project

Run Django's `migrate` command and load the fixture data:

    $ cd project_stories
    $ python manage.py migrate
    $ python manage.py loaddata ../fixtures/sites.json
    $ python manage.py loaddata ../fixtures/users.json
    $ python manage.py loaddata ../fixtures/stories.json
    $ python manage.py loaddata ../fixtures/comments.json

And finally launch the development server:

    $ python manage.py runserver

## About users

The project allows you to login using any of the users provided with the `users.json` fixture. There are 110 users. Here are the login email and password of the first 10. The rest follow the same pattern; they have as password the left side of the email address:

 * `admin@example.com`, password `admin`
 * `fulanito@example.com`, password `fulanito`
 * `mengo@example.com`, password `mengo`
 * `daniela.rushmore@example.com`, password `daniela.rushmore`
 * `lena.rosenthal@example.com`, password `lena.rosenthal`
 * `amalia.ocean@example.com`, password `amalia.ocean`
 * `isabel.azul@example.com`, password `isabel.azul`
 * `joe.bloggs@example.com`, password `joe.bloggs`
 * `eva.rizzi@example.com`, password `eva.rizzi`
 * `david.fields@example.com`, password `david.fields`
