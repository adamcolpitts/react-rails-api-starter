Rails.application.routes.draw do
  resources :drinks do
    resources :ingredients
  end
end
