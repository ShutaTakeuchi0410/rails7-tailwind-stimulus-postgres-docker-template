FROM ruby:3.1.2

RUN gem install "bundler:~>2.0" --no-document && \
  gem update --system && \
  gem cleanup

# App dependencies

RUN apt-get update -qq && \
  apt-get install -y build-essential libpq-dev vim

# App

WORKDIR /app
COPY ./Gemfile* /app/
RUN bundle install --jobs $(nproc) --retry 5
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]