# 従来の Dockerfile (Rails 8 / Ruby 3.4)
FROM ruby:3.4-slim
WORKDIR /app

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      build-essential libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

COPY . .

ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=1 \
    PORT=8080

EXPOSE 8080
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
