class HealthController < ApplicationController
  def show
    render json: {
      status: "ok",
      service: "dhi-rails-sample",
      ruby: RUBY_VERSION,
      rails: Rails.version,
    }
  end
end
