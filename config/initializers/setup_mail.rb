# setup_mail.rb instructions to configurate  heroku to send emails to the users using sengrid

# $heroku auth:logout
# $heroku addons:add sendgrid:starter
# $heroku addons
# $heroku config:get  SENDGRID_USERNAME
# "heroku gives you your_sendgrid_username"
# $heroku config:get  SENDGRID_PASSWORD
# "heroku gives you your_sendgrid_password"


# the code below stays here just replace the 
# variables your_sendgrid_username and your_sendgrid_password
# that you get from heroku

# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings = {
#   :address              =>  'smtp.sendgrid.net',
#   :port                 =>  '587',
#   :authentication       =>  :plain,
#   :user_name            =>  'your_sendgrid_username@heroku.com',
#   :password             =>  'your_sendgrid_password',
#   :domain               =>  'heroku.com',
#   :enable_starttls_auto  =>  true
# }

