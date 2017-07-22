# ALRails v7501.0

Active Learning on Rails

Features:
------
- Live Lectures: Professors can manage lecture questions all from a browser
- Reusable question sets
- Login via Georgia Tech's Single Sign-On service: students and professors can use their gatech credentials
- Adds a Teaching Assistant (TA) role so that TAs can help manage courses by creating questions and question sets
- Statistics at the course, lecture, and user level

Known Issues:
-------
- App is not "hardened" from all unauthorized actions. For example, if a user guesses a URL to a resource they shouldn't have access to, they may be able to see it. Because our app is not storing passwords or other such sensitive information, it is not that big of an issue.
- Performance testing was not performed. We do not know how the app will handle when the database grows to be very large or has many concurrent users requesting pages.

Installation:
-------
First ensure that you have a newer version (> 2.4) of ruby installed. You will need sqlite too.
`bundle install` will install the necessary dependencies for the project to run.

Database:
------
`rails db:migrate` will update the tables in the database. This is necessary when setting up, or when you add migrations to the project.

`rails db:reset` will dump all the data out of the tables and then execute the `db/seeds.rb` file to populate the tables. This is useful when doing testing locally. When the state of the database is modified, use this command to rollback.

`bundle exec erd` will generate an ER diagram to erd.pdf.

Starting the application:
-------
`rails server` will start the application. It will listen on `localhost:3000/` however note that the root of the application (`/`) doesn't route to anything (yet) so you will need to navigate to `localhost:3000/courses` or something similar.

Production Deployment:
------
Go ahead and install all the software dependencies. Next migrate the database, but do not seed with our dummy data. At least one person will need to be the admin of the site. Go ahead and insert a record for each admin in the User table in the sqlite database with the admin bit set. Execute `rails server -e production` to start the application in production mode. The application will want to bind to port 3000. To serve traffic on port 80, we suggest a reverse proxy like nginx.

Logging in to the application:
-------
Since our application will use SSO, there is no reason to have a true login system for local development. Locally, give the url a query string to login, such as: `localhost:3000/courses?un=rkalhan4` and you will be logged in as a user with the username `rkalhan4`. When the application is in production, it should automatically redirect the user to the gatech login system.

Troubleshooting:
-------
Most problems can be fixed by resetting the database. Delete the sqlite files in `db/` and setup the database again (see the database section of this document).
