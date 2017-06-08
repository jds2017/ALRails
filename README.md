# ALRails
Active Learning on Rails

First ensure that you have a newer version (> 2.4) of ruby installed.
`bundle install` will install the necessary dependencies for the project to run.

Database:
------
`rails db:migrate` will update the tables in the database. This is necessary when setting up, or when you add migrations to the project.

`rails db:reset` will dump all the data out of the tables and then execute the `db/seeds.rb` file to populate the tables. This is useful when doing testing locally. When the state of the database is modified, use this command to rollback.

Starting the application:
-------
`rails server` will start the application. It will listen on `localhost:3000/` however note that the root of the application (`/`) doesn't route to anything (yet) so you will need to navigate to `localhost:3000/courses` or something similar.

Logging in to the application:
-------
Since our application will use SSO, there is no reason to have a true login system. Locally, give the url a query string to login, such as: `localhost:3000/courses?un=rkalhan4` and you will be logged in as a user with the username `rkalhan4`
