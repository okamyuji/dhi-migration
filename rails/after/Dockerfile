# DHI 移行後 (Rails 8 / Ruby 3.4)
# syntax=docker/dockerfile:1
FROM dhi.io/ruby:3.4-debian12-dev AS builder
WORKDIR /app

ENV BUNDLE_PATH=/app/vendor/bundle \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT="development:test"

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4

COPY . .

FROM dhi.io/ruby:3.4-debian12
WORKDIR /app

ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=1 \
    PORT=8080 \
    BUNDLE_PATH=/app/vendor/bundle \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT="development:test" \
    PATH="/app/vendor/bundle/ruby/3.4.0/bin:${PATH}"

COPY --from=builder --chown=nonroot:nonroot /app /app

USER nonroot
EXPOSE 8080
# DHI runtime image is distroless (no shell, no `bundle` binary).
# Invoke ruby directly via the bin/start.rb launcher.
CMD ["ruby", "bin/start.rb"]
