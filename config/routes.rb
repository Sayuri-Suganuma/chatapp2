Rails.application.routes.draw do
  # get 'homes/top'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "homes#top"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
