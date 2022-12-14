Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'example#index', as: 'index'
  get '/redirect', to: 'example#redirect', as: 'redirect'
  get '/callback', to: 'example#callback', as: 'callback'
  get '/calendars', to: 'example#calendars', as: 'calendars'
  get '/events/:calendar_id', to: 'example#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'example#new_event', as: 'new_event', calendar_id: /[^\/]+/
end
