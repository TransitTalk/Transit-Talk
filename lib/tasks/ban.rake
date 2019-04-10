desc 'Bans the user with the given email.'
task :ban_user, [:email] => [:environment] do |task, args|
  email = args[:email]

  if email.present?
    User.ban_user!(email)
  else
    $stderr.puts 'Please provide an email!'
  end
end
