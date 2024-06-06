# Use an official Ruby runtime as a parent image
FROM ruby:3.1.1

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install --global yarn

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile Gemfile.lock ./

# Install any necessary dependencies
RUN bundle install --without development test --deployment --path vendor/bundle

# Copy the rest of the application code into the image
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]