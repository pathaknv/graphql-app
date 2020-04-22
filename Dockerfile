FROM ruby:2.5.1

WORKDIR /usr/graphql-app

COPY ./Gemfile ./
COPY ./Gemfile.lock ./
RUN bundle install

COPY ./db/migrate ./
RUN rails db:migrate

COPY ./ ./

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

CMD ["rails","s", "-b", "0.0.0.0", "--"]
