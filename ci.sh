# Continuous Integration - run by Travis or can be run locally

# Run DB migrations on the test ENV
RAILS_ENV=test bundle exec rake db:migrate

# Run Rubocop for Rails and HTML linting
bundle exec rubocop

# Run Rails tests
bundle exec rake

# Run HTML Proofer with the following parameters:
#
# --assume-extension			- Fix needing the .html extension on links
# --check_html					- Check for HTML errors using Nokogiri
# --enforce_https				- Enforce HTTPS (since hosted on HTTPS)
# --empty_alt_ignore			- Ignore empty alt tags, which indicate that an
# image is decorative
#
# Learn more: https://github.com/gjtorikian/html-proofer#configuration
htmlproofer ./_site --assume-extension --check-html --enforce_https --empty_alt_ignore

# Run stylelint on the `/_sass` directory with root files (main.scss) first,
# then sub files like partials
stylelint app/assets/stylesheets/*.scss
