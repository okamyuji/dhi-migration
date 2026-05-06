Rails.application.routes.draw do
  get "/health", to: "health#show"
  root to: "health#show"
end
