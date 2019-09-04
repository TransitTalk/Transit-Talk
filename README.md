## Transit Talk

[![Build Status](https://travis-ci.org/TransitTalk/Transit-Talk.svg?branch=master)](https://travis-ci.org/TransitTalk/Transit-Talk)
[![Coverage Status][coverage-status-icon]][coverage-status]

Transit Talk is a crowd-sourced issue reporting platform for public transit systems. It's a friendly place for transit riders to share information about system delays, vehicle cleanliness, and other common challenges of mass transit in real time, making each report visible to every other rider of that system. Transit Talk augments or replaces reporting tools maintained by transit administrators, collecting rider feedback while empowering riders to make daily decisions based on reports from other riders. Behind the scenes, Transit Talk is an open-source framework that can be implemented easily for any transit system that uses GTFS-formatted information. Presently, Transit Talk is able to:

  * Process GTFS-formatted data and output accurate details regarding routes and stations.

  * Act as a community forum where issues reports regarding discrepancies in a transit system are publicly visible to other riders.

  * Track the location of a rider, presenting the nearest stations and routes of transportation to the rider.

  * Manage individual users with an account system that offers custom settings such as 'Favorite' stations and routes.

<br>

In the future we hope to expand the functionality of Transit Talk by:

  * Analyzing issue patterns and their effect on a rider's commute in order to suggest alternative routes that improve efficiency.

  * Implementing real-time rendering of transportation vehicles as they move.

  * Creating an accountability system that will allow deletion of the accounts of habitual spammers.

  * Consistently resolving bugs as they appear during the development process. Unresolved issues are logged on [GitHub][issues].

<br>

## Using Transit Talk

 Transit Talk's user interaction occurs through a mobile-first website that allows transit riders to view recently reported issues at nearby stations and on nearby vehicles.

 [//]: # (Homescreen w/o account photo TBD)

 For a rider to report, they must first log in or create an account. Navigation between pages is largely centered around the menu icon in the top left corner, which opens a directory side menu (also accessible through a rightward swipe on a touchscreen).

 [//]: # (Insert Side Menu pic)

 The platform utilizes a standard account creation process requiring an email address and a password. Once logged in, two core features are unlocked for the user: 'Favorite' stops and report submission.

 [//]: # (Insert issue report page pic)

 The issue report form is broken up into multiple segments, which display different options based on rider input. Depending on which transit line is chosen by the rider, a list of all the stops on that line are listed and can be selected as the origin point for an issue. From there, the rider can classify the issue in various ways and provide a freeform text description explaining any relevant details.

<br>

## BUILD/INSTALLATION INSTRUCTIONS

### Windows 10

* [Install Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) (further instructions should be done in a WSL terminal/prompt)
* [Install RVM](https://github.com/rvm/ubuntu_rvm)
* `rvm install ruby`
  * If you have issues, see [this StackOverflow](https://github.com/rvm/ubuntu_rvm)
* `rvm install v.v.v`
  * `v.v.v` is the current version of Ruby being used for the project
* `rvm use v.v.v`
* `gem install bundler`
* Set up to install the `mysql2` gem later:
  * `sudo apt-get update`
  * `sudo apt-get upgrade`
  * `sudo apt-get install libmysqlclient-dev`
* `sudo apt-get install nodejs`
  * We need to have a JavaScript runtime installed for running Transit-Talk

### Ruby on Rails v2.4.4 and Other Packages

All necessary packages for running this software are provided in the GEMFILE included in the source code. Use the command:

```
$ bundle install
```

to install all packages listed.

#### MySQL gem issues

If you have problems installing the `mysql2` gem, the likeliest explanation is that you are missing some MySQL system libraries and headers that this gem needs to link against. Consult the [mysql2 gem documentation](https://github.com/brianmario/mysql2#general-instructions) for possible remedies, or see below.

* Debian GNU/Linux: `sudo apt install libmariadb-dev`
* WSL: `sudo apt-get upgrade`, then `sudo apt-get install libmysqlclient-dev`
* macOS
  * `brew install mysql` will install to /usr/local/Cellar/mysql/x.x.x
  * `gem install mysql2 -v 'y.y.y' -- --srcdir='/usr/local/Cellar/mysql/x.x.x/include'`
    * `x.x.x` is where brew installed mysql
    * `y.y.y` is the required `mysql2` version listed in the GEMFILE

### Local Testing

Navigate to root directory of the project, run `rails db:migrate` to create the database, then run `rails server`. Connect to [localhost:3000](http://localhost:3000) on your browser.

## Contributor Guide
To learn more about how to contribute to Transit Talk's development, check out [our contribution guidelines][contributing].

### Adding New Modular Settings
To add a new modular setting to the settings panel (`/settings`), add it as a default in `config/app.yml` and then add the display name of the attribute in
`config/locales/en.yml` under `en.settings.attributes.{{new_setting_name}}.name`. For example, when adding the `theme_color` setting, we added a default theme_color of `theme_color: "#58b7ff"` and then added `en.settings.attributes.theme_color.name = "CSS Theme Color"`.

## License

Copyright 2018. Copyright shared among all those listed in [CONTRIBUTORS][contributors]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

## Creating Your Own Transit Talk App

### Loading Data from transit.land

Start by finding the transit operator you want to set up an app for from [transit.land's feed registry](https://transit.land/feed-registry/). Copy the `onestop_id` for the desired operator.

Then, run `rake transit:set_up_transitland TLAND_AGENCY_ONESTOP_ID=%onestop_id%`

A nice [transit operator](https://transit.land/feed-registry/operators/o-drke-9towntransit) to use for testing: `rake transit:set_up_transitland TLAND_AGENCY_ONESTOP_ID=o-drke-9towntransit`


Alternatively, the transit agency's onestop_id can be pulled from environment variables, so setting the `TLAND_AGENCY_ONESTOP_ID` environment variable to your desired onestop_id and then running `rake transit:set_up_transitland` will also work.

### Loading GTFS Data (Deprecated)
**Note:** This method is now deprecated for the transit.land data import mentioned above

Get the URL for the GTFS data, which we'll call _data_url_.

Download the file using wget - `wget '_data_url_'`

Load in the data using the Rake task - `rake transit:set_up_transit GTFS_FILE=_path_to_data_file_`

### Customizing Your Transit Talk App
We use [rails-settings-ui](https://github.com/accessd/rails-settings-ui) (a UI wrapper for [rails-settings-cached](https://github.com/huacnlee/rails-settings-cached)), which lets you tweak certain global setttings for your Transit Talk app.

To change your settings, go to http://your-app-url/settings. Once your settings are updated, you should see the changes reflected immediately (if they are non-styling changes) or upon the next server restart. If you need to manually rebuild to test your settings: close your server, run `rm -fr tmp/cache` to clear built Sass files, and rerun your server.

[coverage-status-icon]: https://coveralls.io/repos/github/CaravanTransit/Caravan-App/badge.svg?branch=master
[coverage-status]: https://coveralls.io/github/CaravanTransit/Caravan-App?branch=master
[issues]: https://github.com/CaravanTransit/Transit-Talk/issues
[contributing]: https://github.com/CaravanTransit/Transit-Talk/blob/master/CONTRIBUTING.md
[contributors]: https://github.com/CaravanTransit/Transit-Talk/blob/master/CONTRIBUTORS.md
