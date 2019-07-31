namespace :user do
  desc 'Bans the user with the given email.'
  task :ban_user, [:email] => [:environment] do |task, args|
    email = args[:email]

    if email.present?
      User.ban_user!(email)
    else
      $stderr.puts 'Please provide an email!'
    end
  end

  desc 'Makes the user with the given email an admin'
  task :make_admin, [:email] => [:environment] do |_, args|
    email = args[:email]

    if email.present?
      u = User.find_by_email(email)
      return unless u.present?

      u.admin = true
      u.save
    else
      $stderr.puts 'Please provide an email!'
    end
  end
end


