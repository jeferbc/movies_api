## API endpoints

## GET
* Get movies by day of presentation:
```
curl 'https://shrouded-sierra-13385.herokuapp.com/api/movies?day=2020-03-26'
```
```
parameter: day, required: true, ex: 2020-03-26
```
Response
```
[{"id":1,"name":"movie","description":"description","url_image":"https://fakeimg.pl/300/","day":"2020-03-26","movie_id":1}]
```
```
id: presentation id
name: movie name 
description: movie description
url_image: movie image
day: presentation day
movie_id: movie id
```
* Get reservations by range of days of presentations:
```
curl 'https://shrouded-sierra-13385.herokuapp.com/api/reservations?start_day=2020-03-26&end_day=2020-03-27'
```
```
parameter: start_day, required: true, ex: 2020-03-26
parameter: end_day, required: true, ex: 2020-03-27
```
Response
```
[{"id":1,"day":"2020-03-26","movie_id":1,"username":"berna","presentation_id":1}]
```
```
id: reservation id
day: presentation day 
movie_id: movie id
username: username
presentation_id: presentation id
```

## POST
* Create a movie:
```
curl -X POST -H 'Content-Type: application/json' -d '{"name":"movie","description":"description", "url_image": "https://fakeimg.pl/300/", "presentations": [{"day": "2020-03-26"}]}' https://shrouded-sierra-13385.herokuapp.com/api/movies
```
```
parameter: name, required: true, ex: Movie name
parameter: description, required: true, ex: Movie description
parameter: url_image, required: true, ex: https://fakeimg.pl/300/
parameter: presentations, required: true, ex: [{"day": "2020-03-26"}, {"day": "2020-03-27"}]
parameter: day, required: true, ex: 2020-03-26
```
Response
```
{"movie":{"id":2,"name":"movie","description":"description","url_image":"https://fakeimg.pl/300/","presentations":[{"id":1,"day":"2020-03-26","movie_id":2}]}
```
```
movie: movie created with it's presentations
```
* Create reservation (max 10 reservations per presentation):
```
curl -X POST -H 'Content-Type:application/json' -d '{"presentation_id":"1","username":"username"}' https://shrouded-sierra-13385.herokuapp.com/api/reservations
```
```
parameter: presentation_id, required: true, ex: 1
parameter: username, required: true, ex: username
```
Response
```
{"reservation":{"id":1,"username":"username","presentation_id":1}}
```
```
reservation: reservation create
```
## Setup

Setup
This is a Grape project that uses PostgreSQL as the database. Once you have that installed,
download the project by cloning it from Git:
```
$ git clone git@github.com:jeferbc/movies_api.git
```
Then, install the dependencies with:

```
$ bundle install
```

Create the database

We need to create two databases, one for test, called theaters_test and the other for development, 
called theaters_development accordign to postgres documentation
https://www.postgresql.org/docs/9.0/sql-createdatabase.html

After you create the databases, run the migrations by executing:

```
$ sequel -m db/migrations postgres://localhost/theaters_test
```
```
$ sequel -m db/migrations postgres://localhost/theaters_development
```

## Contributing

The workflow for contributing to this project is the following:

**1. Identify an issue you want to work on**

Checkout the issue in github

**2. Create a branch**

```
$ git checkout master
$ git pull
$ git checkout -b xx-short-description
```

The name of the branch should start with the number of the issue, followed by max three keywords that describe the issue (e.g. `23-fix-homepage`, `56-change-font`, etc.).

**3. Work on the branch**

Commit often and try to create small commits, just be sure that the tests are passing before commiting. Rebase against the upstream frequently to prevent your branch from diverging significantly:

```
$ git fetch origin
$ git rebase origin/master
```

Once you finish, you can push the branch and initiate a pull request.

**Note:** remember that an issue is not finished until it's fully tested!

**4. Push the branch and initiate the pull request**

When you are done, and you have organized your commits locally, it's time to push the branch.

```
$ git push -u origin xx-short-description
```

Open a pull request (PR) on Github.

### Writing good commit messages

A commit message has a first line, a blank line and an optional body. For example (taken from the Rails repository):

```
Make flash messages cookie compatible with Rails 4

In #xxx we removed the discard key from the session hash used to flash
messages and that broke compatibility with Rails 4 applications because they
try to map in the discarded flash messages and it returns nil.

Fixes #xxx.
```

Notice that the first line and the body are capitalized. The first line should be 50 characters or less and should start with a verb (e.g. make, fix, create, implement, add, etc.).

The body should be wrapper to 72 characters and you can reference any issue and [use keywords to close them](https://help.github.com/articles/closing-issues-via-commit-messages/).

**Tip:** Think about sending an e-mail to a colleague where the first line is the subject of the email, and the body is the body of the e-mail.
