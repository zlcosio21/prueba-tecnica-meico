FROM ruby:3.2.4

RUN apt-get update && apt-get install -y build-essential libsqlite3-dev

WORKDIR /home/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]