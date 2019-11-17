## Contributing to Transit Talk

Thanks for being here! Our project has grown out of a regional hackathon and is now part of Chi Hack Night, a weekly civic tech meetup.

If you want to get started with the project, read on!

## Resources and Links

To ease the learning and involvement curve for this project, we have a few resources to look over as you wish. Some of these will be helpful to understand the project's motivations, while some are more specific to the technologies we use.

* The contributing guidelines document. Oh, hey, you're already here!
* Day-to-day project discussion takes place in [the Chi Hack Night Slack group](https://slackme.chihacknight.org/). Our channel is called #transit-talk.
* Bugs can be reported through [GitHub Issues][issues].
* [We have a wiki, too!][wiki] That document covers more than just development-related topics, and is still being actively built.
* GTFS Primer: Transit Talk heavily relies on the General Transit Feed Specification (GTFS), originally developed by Google but now widely supported by transit agencies around the world. If you are unfamiliar with GTFS data or what the overall purpose of the data standard is, check out [Google's documentation on the project](https://developers.google.com/transit/gtfs/).
* Transit Talk uses [Transitland](https://transit.land/), which is a curated database of open GTFS data for transit systems around the world. Transitland provides data in a few different forms that are different than the raw GTFS standard, so it's worth exploring their own docmentation.
* This project was born in Illinois, and most active development comes from folks in Chicago, so many of our testers and contributors are currently using [CTA GTFS data](http://www.transitchicago.com/developers/gtfs.aspx). Our first running prototype is built using that CTA data.

## BUILD/INSTALLATION INSTRUCTIONS

### Windows 10

* [Install Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) (all instructions after installation should be done in a WSL terminal/prompt)
* [Install RVM](https://github.com/rvm/ubuntu_rvm)
* `rvm install ruby`
  * If you have issues, see [this document for troubleshooting](https://github.com/rvm/ubuntu_rvm)
* `rvm install v.v.v`
  * `v.v.v` is the current version of Ruby being used for the project (2.6.5 at the time of the last update to this document)
* `rvm use v.v.v`
* `gem install bundler`
* Set up to install the `mysql2` gem later:
  * `sudo apt-get update`
  * `sudo apt-get upgrade`
  * `sudo apt-get install libmysqlclient-dev`
* `sudo apt-get install nodejs`
  * You will need to have a JavaScript runtime installed to run Transit-Talk

### Other Packages Needed for Development

All necessary packages for running this software are provided in the GEMFILE included in the source code. Use the command:

```
$ bundle install
```

to install all packages listed.

#### MySQL Gem Issues

If you have problems installing the `mysql2` gem, the likeliest explanation is that you are missing some MySQL system libraries or headers that this gem needs to link against. Consult the [mysql2 gem documentation](https://github.com/brianmario/mysql2#general-instructions) for possible remedies, or see below.

* Debian GNU/Linux: `sudo apt install libmariadb-dev`
* WSL: `sudo apt-get upgrade`, then `sudo apt-get install libmysqlclient-dev`
* macOS:
  * `brew install mysql` will install to /usr/local/Cellar/mysql/x.x.x
  * `gem install mysql2 -v 'y.y.y' -- --srcdir='/usr/local/Cellar/mysql/x.x.x/include'`
    * `x.x.x` is where brew installed mysql
    * `y.y.y` is the required `mysql2` version listed in the GEMFILE

### Local Testing

Navigate to root directory of the project, run `rails db:migrate` to create the database, then run `rails server`. Connect to [localhost:3000](http://localhost:3000) on your browser.

### Adding New Modular Settings
To add a new modular setting to the settings panel (`/settings`), add it as a default in `config/app.yml` and then add the display name of the attribute in
`config/locales/en.yml` under `en.settings.attributes.{{new_setting_name}}.name`. For example, when adding the `theme_color` setting, we added a default theme_color of `theme_color: "#58b7ff"` and then added `en.settings.attributes.theme_color.name = "CSS Theme Color"`.

### Where can I ask for help?
Our Slack channel is specifically intended to encourage discussion among community members. If you have a problem that a web search can't solve, feel free to post about it in the Slack channel.

[issues]: https://github.com/CaravanTransit/Transit-Talk/issues
[wiki]: https://github.com/CaravanTransit/Transit-Talk/wiki
[contributors]: https://github.com/CaravanTransit/Transit-Talk/blob/master/CONTRIBUTORS.md

## Bug Reports and Issues

We use the GitHub Issues platform tied into this repository to manage most feature and issue discussions. If you found something that went haywire, have suggestions, or need help, go there first.

* Templates:
  * What is wrong:
  * Exact steps to recreate bug (if possible):
  * Error Log:

* First bugs for Contributors
  * Edit framework to accomodate different data sets from other transit centers

## Style Guide / Coding conventions
We utilize the Airbnb style guide. Specifics about the style can be found [here](http://airbnb.io/projects/styleguides/). In order to help keep Ruby style consistent we use [RuboCop](bocop.readthedocs.io/en/latest/).

### RuboCop: Better Style Through Static Code Analysis
The [RuboCop](https://github.com/bbatsov/rubocop) tool can lint ruby files for style violations that would be otherwise tedious to memorize
and apply consistently. It provides an agreed-upon style 'baseline' so that contributors can focus on higher-level code structure and decisions.

* `rake rubocop` will run rubocop against all (.rb) files in `app`, `lib`, and `test`.
* `bundle exec rubocop <filename>` will run rubocop against a specific file.
* `bundle exec rubocop --auto-correct` will run rubocop and fix issues if possible
* While it would be nice if you would update code to follow suggested styles, keep in mind that rubcop
  can be overridden if needed (see 'Disabling Cops within Source Code' in the [RuboCop docs](https://rubocop.readthedocs.io/en/latest/)).
* RuboCop style is (mostly) based on the Ruby on Rails style (via the [rubocop-rails gem](https://github.com/toshimaru/rubocop-rails)).

## Creating Your Own Transit Talk App

### License

We encourage you to fork this repository and create custom versions of Transit Talk for your local transit system! That said, we need to get a little legal language out of the way:

Copyright 2019. Copyright shared among all those listed in [CONTRIBUTORS][contributors]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

### Loading Data from transit.land

To make Transit Talk work for your community, you will need to find data for your local transit agency. Start by searching for the transit operator you want to set up an app for in [Transitland's feed registry](https://transit.land/feed-registry/). Copy the `onestop_id` for the desired operator.

Then, in the folder containing your application, run `rake transit:set_up_transitland TLAND_AGENCY_ONESTOP_ID=%onestop_id%`

A nice [transit operator](https://transit.land/feed-registry/operators/o-drke-9towntransit) to use for testing: `rake transit:set_up_transitland TLAND_AGENCY_ONESTOP_ID=o-drke-9towntransit`


Alternatively, the transit agency's onestop_id can be pulled from environment variables, so setting the `TLAND_AGENCY_ONESTOP_ID` environment variable to your desired onestop_id and then running `rake transit:set_up_transitland` will also work.

### Customizing Your Transit Talk App
We use [rails-settings-ui](https://github.com/accessd/rails-settings-ui) (a UI wrapper for [rails-settings-cached](https://github.com/huacnlee/rails-settings-cached)), which lets you tweak certain global setttings for your Transit Talk app.

To change your settings, go to http://your-app-url/settings. Once your settings are updated, you should see the changes reflected immediately (if they are non-styling changes) or upon the next server restart. If you need to manually rebuild to test your settings: close your server, run `rm -fr tmp/cache` to clear built Sass files, and rerun your server.

## Code of Conduct
This is a constructive environment. No discrimination against any members of this team and community will be tolerated here, in our Slack channel, or anywhere else that Transit Talk project planning happens.

## Recognition model
We value every bit of energy that is devoted to this project. If you have contributed to the project through a pull request, issue and evaluation management, or in some other way, you can ask for recognition in the repository's [CONTRIBUTORS.md][contributors] file. Just let us know [on Slack](https://github.com/TransitTalk/Transit-Talk/wiki/Join-Our-Slack)!
