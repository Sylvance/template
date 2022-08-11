FROM ruby:3.0.4 AS Builder

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev yarn nodejs libc6

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler:2.3.17

RUN bundle install

FROM ruby:3.0.4

COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN chmod +x bin/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["./bin/entrypoint.sh"]

CMD ["server"]
