[![Build Status](https://travis-ci.org/codeforamerica/homebase.svg?branch=master)](https://travis-ci.org/codeforamerica/homebase)

Homebase
========

<img src="http://i.imgur.com/Pa5lhV2.gif" />

Homebase is a tool to help San Antonio homeowners fix up their homes. The current version is focused on streamlining the permit selection and application process for basic renovation projects, like building additions or fixing up doors.

This software is under development by the Code for America San Antonio fellowship team in collaboration with the City of San Antonio, TX.

### This is early-stage software

Homebase is a very young application still under rigorous development. It regularly breaks. We frequently wipe out and rewrite chunks of the code. If you want to tinker with the application, please keep in mind it is not ready for prime time.

(But if you'd like to poke around, fix some things and make a pull request, take a look at Pull Requests Welcome section below.)

### What it does now and where we're going

Right now, we can help users decide what project they want to work on (i.e. building a new bedroom on to their house) and help them apply for the appropriate permits for that project.

Going forward, we want to extend this functionality to include a number of different home repair and upgrade projects. We're also interested in using the information we collect during the application process to match users with free grants to fund their projects, and certified contractors to complete the work.

# Install and deploy

Homebase has been tested and deployed locally and on the Heroku platform. We'll cover local installation first, then Heroku deployment.

### Pre-requisites

You'll need the following set up to run Homebase:

* [Ruby](https://github.com/codeforamerica/howto/blob/master/Ruby.md)
* [Rails](https://github.com/codeforamerica/howto/blob/master/Rails.md)
* [PostgreSQL](https://github.com/codeforamerica/howto/blob/master/PostgreSQL.md)
* [GEOS](http://trac.osgeo.org/geos/) - You may need to adjust RGeo gem GEOS installation directory to point to your installation
* [PDFtk](http://www.pdflabs.com/tools/pdftk-server/) - A tool Homebase uses to fill in PDF documents

### Local Installation

All of these commands should be entered into your command line tool of choice.

#### 1. Clone the app to your computer and open the folder

    $ git clone https://github.com/codeforamerica/homebase.git
    $ cd homebase

#### 2. Install the dependencies

    $ bundle install

#### 3. Create and migrate your database

Homebase has a simple database that stores information users enter into the forms. You'll just need to create the databases on your local PostgreSQL installation.

    $ bundle exec rake db:create
    $ bundle exec rake db:migrate

Homebase checks if a user's address is in San Antonio (that's the only city we're supporting now). We have a pre-setup database (cosa_boundaries) that contains the geometry to allow us to check addresses. You'll need to import (or another boundary database you substitute) to get the app working.

    $ bundle exec rake cosa_boundaries:load

#### 4. Add your API keys and Login information

Copy the file .env_example to .env, and change all the keys on the file.  Remember to not check in this file to a public repository, as you don't want others to have this information.

Our application currently requires the following keys: 

* GOOGLE_GEOCODER_API_KEY:
  * You can get your own Geocoder Server Key from here: [Google Geocoding API](https://developers.google.com/maps/documentation/geocoding/)

* SENDGRID_USERNAME and SENDGRID_PASSWORD: 
  * You can get your own SendGrid credentials at [SendGrid](http://www.sendgrid.com)

#### 5. Start your web service

Homebase uses the [Foreman](http://theforeman.org/) web server. It's easy to start up.

    $ bundle exec foreman start

#### You're good to go locally.

Check out your Homebase instance at [0.0.0.0:5000](http://0.0.0.0:5000) and have some fun.

### Deploy to Heroku

Things get a little tricky here. You'll need a [Heroku](https://heroku.com) to go forward. You'll also need to install the [Heroku Toolbelt](https://toolbelt.heroku.com/) so you can easily interact with Heroku from the command line.

#### 1. Create a new Heroku app, or connect to an existing one

Make sure you're in the folder for your app before you get started. Now, let's make our app.

    $ heroku create

Alternatively, you can connect to an existing app:

    $ heroku git:remote -a project-name-here

#### 2. Add the heroku-postgresql addon

You'll also need to upgrade to the Standard Yanari package (this costs $50/month).

    $ heroku addons:add heroku-postgresql:standard-yanari

#### 3. Add Heroku Config Vars

    $ heroku config:set BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git
    $ heroku config:set LD_LIBRARY_PATH=/app/lib
    $ heroku config:set PDFTK_PATH=/vendor/pdftk/bin/pdftk
    $ heroku config:set GOOGLE_GEOCODER_API_KEY=REPLACE YOUR API KEY HERE

#### 4. Change your database config

You'll need to set up your Heroku PostgreSQL addon to use PostGIS. First, check out your config.

    $ heroku config

You'll see something like this:

    === project-name-here Config Vars
    DATABASE_URL:               postgres://xxxxxxxxxxxxxxxxxxx@xxx-xxx-xxxx-xxxxxx-xxxxxxxxx.xxxxxxxxxx-x.amazonaws.com:XXXX/xxxxxxxxx
    HEROKU_POSTGRESQL_COLOR_URL: postgres://xxxxxxxxxxxxxxxxxxx@xxx-xxx-xxxx-xxxxxx-xxxxxxxxx.xxxxxxxxxx-x.amazonaws.com:XXXX/xxxxxxxxx
    LANG:                       en_US.UTF-8
    RACK_ENV:                   production
    RAILS_ENV:                  production

We'll need to change those `postgres://` referers to `postgis://`.

    $ heroku config:set DATABASE_URL=postgis://xxxxxxxxxxxxxxxxxxx@xxx-xxx-xxxx-xxxxxx-xxxxxxxxx.xxxxxxxxxx-x.amazonaws.com:XXXX/xxxxxxxxx
    $ heroku config:set HEROKU_POSTGRESQL_COLOR_URL=postgis://xxxxxxxxxxxxxxxxxxx@xxx-xxx-xxxx-xxxxxx-xxxxxxxxx.xxxxxxxxxx-x.amazonaws.com:XXXX/xxxxxxxxx

Make sure that's the URL for your actual datbase from the heroku config info. Make sure you replace `COLOR` with the color for your database.

#### 5. Push your repo up

    $ git push heroku master

#### 6. Enable PostGIS support

##### First log into your database
    $ heroku pg:psql HEROKU_POSTGRESQL_COLOR_URL

##### Enable PostGIS
    $ CREATE EXTENSION postgis;

##### Exit out of your database
    $ \q

#### 7. Now let's migrate the database

    $ heroku run rake db:migrate

#### 8. Load your data

    $ heroku run rake cosa_boundaries:load

#### 9. Your app is good to go

Check it out at project-name-here.herokuapp.com.

# Contribute

If you see a problem, please [submit an issue](https://github.com/codeforamerica/homebase/issues). 

If you'd like to contribute some code to our project, please follow this great [guide on contributing through Pull Requests](https://guides.github.com/activities/contributing-to-open-source/#contributing) from Github. We welcome Pull Requests big and small: you can help squash a bug or even just fix a typo.

# Say hello

This application is being developed by the Code for America San Antonio fellowship team. We call ourselves the Techzans. (Get it?)

* Amy Mok  [twitter](https://twitter.com/amymok) | [website](http://mokamy.com) | [github](https://github.com/amymok)
* Maya Benari  [twitter](https://twitter.com/mayabenari) | [website](http://maya-benari.com/) | [github](https://github.com/maya-)
* David Leonard  [twitter](https://twitter.com/davidleonardii) | [website](http://davidleonard.me) | [github](https://github.com/davidrleonard)

To send us your thoughts, [submit an issue](https://github.com/codeforamerica/homebase/issues) or email us all at [sanantonio@codeforamerica.org](mailto:sanantonio@codeforamerica.org).

# Copyright

Homebase is Copyright (c) 2014 by Code for America. But you can copy or fork and use it to your delight, as long as you read and follow our [license](https://github.com/codeforamerica/homebase/blob/master/LICENSE).