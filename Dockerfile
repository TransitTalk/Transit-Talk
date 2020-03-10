FROM ruby:2.6.5
# RUN apt-get remove cmdtest
# RUN apt-get remove yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn default-libmysqlclient-dev
RUN gem install bundler
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY . /app

RUN bundle install
RUN yarn install

# ENTRYPOINT ["entrypoint.sh"]

# Add a script to be executed every time the container starts.
EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]