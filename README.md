# ALRails

Active Learning on Rails

Release Notes:
-------
ALRails Version 7501.0

FEATURES:
- Live Lectures: Professors can manage lecture questions all from a browser
- Reusable question sets
- Login via Georgia Tech's Single Sign-On service: students and professors can use theor gatech credentials
- Adds a Teaching Assistant (TA) role so that TAs can help manage courses by creating questions and question sets
- Statistics at the course and user level

KNOWN BUGS:
- App is not "hardened" from all unauthorized actions. FOr example, a user may be able to look at a question from another class if they are able to guess the URL

Installation:
-------
First ensure that you have a newer version (> 2.4) of ruby installed.
`bundle install` will install the necessary dependencies for the project to run.

Database:
------
`rails db:migrate` will update the tables in the database. This is necessary when setting up, or when you add migrations to the project.

`rails db:reset` will dump all the data out of the tables and then execute the `db/seeds.rb` file to populate the tables. This is useful when doing testing locally. When the state of the database is modified, use this command to rollback.

`bundle exec erd` will generate an ER diagram to erd.pdf.

Starting the application:
-------
`rails server` will start the application. It will listen on `localhost:3000/` however note that the root of the application (`/`) doesn't route to anything (yet) so you will need to navigate to `localhost:3000/courses` or something similar.

Logging in to the application:
-------
Since our application will use SSO, there is no reason to have a true login system. Locally, give the url a query string to login, such as: `localhost:3000/courses?un=rkalhan4` and you will be logged in as a user with the username `rkalhan4`
