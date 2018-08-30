unless Rails.env.production?
	require 'rubocop/rake_task'

	desc 'Run RuboCop on the app, lib, and test directories'
	RuboCop::RakeTask.new(:rubocop) do |task|
	  # lib/**/*.rb',
	  task.patterns = ['app/**/*.rb', 'lib/**/*.rb', 'test/**/*.rb']
	  # don't abort rake on failure
	  task.fail_on_error = false
	end
end