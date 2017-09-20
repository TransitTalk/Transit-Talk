# Transit Network [![Build Status](https://travis-ci.org/TransitNetworkGroup/Transit-Network.svg?branch=master)](https://travis-ci.org/vkoves/Transit-Network)

Transit Network is a platform for collective commuters to inquire and report on the status and structure of public transportation stations and lines. Behind the scenes, TransitNetwork is an open-source framework that facilitates efficient implementation of any major transit system that provides their GTFS formatted information. This adaptability to any transportation network provides the potential for an extensive network of locations within one centralized package where users and contributors can take better advantage of transportation resources. Presently, these benefits are products of TransitNetwork's ability to:
  
  * Process GTFS formatted data and output accurate details regarding scheduling, transportation units, and locations.

  * Act as a community forum where peers can report issues regarding discrepancies in the transit system that are publicly visible to other peers. These issues are likewise marked resolved by future users after the issue has dissipated. 

  * Track location which allows for automated presentation of the nearest stops and lines of transportation relative to a user's position.

  * Log individual users with a login system that offers custom settings such as 'Favorite' stops.

<br>

In the future we hope to expand the functionality of TransitNetwork by:

  * Analyzing issues and their effect on a user's commute. From there, suggest alternative routes that improve efficiency.

  * Implementing real-time rendering of transportation unit locations.

  * Including more logistical factors and their effect on transit (i.e. transportation fares).

  * Improving personal abilities to create a creative name.

  * Creating an accountability system that will track an individual user's history of reports and closing of other user's reports. Distribute some form of punishment if logs suggest abuse of the platform.

  * Consistently resolve bugs in the code as they appear over the development process. Unresolved issues are logged on [GitHub](https://github.com/rjaltman/Transit-Network/issues)

<br>

## Using TransitNetwork
 
 TransitNetwork's user interaction occurs through a mobile-oriented website that allows users to view recent reported issues of nearby stops and transportation units. 

 [//]: # (Homescreen w/o account photo TBD)

 For a user to report, they must first login or create an account. Navigation between pages is largely centered around the menu icon in the top left corner which opens a directory side menu (also accessible through a right swipe).

 [//]: # (Insert Side Menu pic)

 The platform utilizes a standard account creation process requiring an email and a password. Once logged in, two core features are unlocked for the user--'Favorite' stops and report submission.
 Reports are created using the '+' icon located in the bottom right corner. The button takes the user to the issue report page.

 [//]: # (Insert issue report page pic)

 The report page has a sequential selection order starting with the transportation line being chosen first. Based on which line is chosen, a list of all the stops on that line are listed and can be selected as an origin of an issue. From there, a user can classify the issue as a 'type' and give a description explaining the details.

<br>
  
## BUILD/INSTALLATION INSTRUCTIONS
  * Ruby on Rails v2.3.0 and Other Packages
    * All necessary packages for running this software are provided in the GEMFILE included in the source-code. Use the command:

      ```
      $ bundle install
      ``` 
    
      to install all packages listed.
   
  * Local Testing
    * Navigate to root directory
   
   ```
   rails server
   ```
   
    * Connect to Localhost:3000 on your browser

## Contributor Guide
To learn more about how to contribute, check out [our contribution guidelines](CONTRIBUTING.md)

## License 

Copyright 2017. Copyright shared among all those listed in [CONTRIBUTORS](CONTRIBUTORS.md)  

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0
    
## Making a New App

### Loading Data from transit.land

Start by finding the transit network operator you want to setup a site for from [transit.land's feed registry](https://transit.land/feed-registry/). Grab the `onestop_id` for the desired operator.

Then run `rake transit:set_up_transitland TLAND_AGENCY_ONESTOP_ID=%onestop_id%`

Alternatively, the transit agency's onestop_id can be pulled from environment variables, so setting the `TLAND_AGENCY_ONESTOP_ID` environment variable to your desired onestop_id and then running `rake transit:set_up_transitland` will also work.

### Loading GTFS Data (Deprecated)
**Note:** This method is now deprecated for the transit.land data import mentioned above

Get the URL for the GTFS data, which we'll call _data_url_.

Download the file using wget - `wget '_data_url_'`

Load in the data using the Rake task - `rake transit:set_up_transit GTFS_FILE=_path_to_data_file_`

### Tweaking The Site
We use [rails-settings-ui](https://github.com/accessd/rails-settings-ui) (a UI wrapper for [rails-settings-cached](https://github.com/huacnlee/rails-settings-cached)) that lets you tweak certain global setttings about your Transit Network site.

To tweak your settings, go to http://your-app-url/settings. Once your settings are updated, you should see the changes reflected immediately (if they are non styling changes) or upon the next server restart. If you need to manually rebuild to test your settings, close your server, run `rm -fr tmp/cache` to clear built Sass files, and rerun your server.