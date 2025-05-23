FROM ruby:3.2
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 9292
CMD ["rackup", "--host", "0.0.0.0"]