Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  
  resources :pokemons, only: %i[index show]
  resources :types, only: %i[index show]
end

Rails.application.routes.default_url_options[:host] = 'www.pokemon-by-nicosek.com'
