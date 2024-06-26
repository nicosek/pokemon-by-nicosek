Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "pokemons#index"
  
  resources :pokemons, only: %i[index show]
  resources :types, only: %i[index show]

  post '/synchronize_with_poke_api', to: 'update_database#synchronize_with_poke_api'
end

Rails.application.routes.default_url_options[:host] = 'www.pokemon-by-nicosek.com'
