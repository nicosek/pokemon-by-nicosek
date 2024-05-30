class UpdateDatabaseController < ApplicationController
  def synchronize_with_poke_api
    PokeApiServices::SynchronizeTypes.new.call
    PokeApiServices::SynchronizePokemons.new.call

    head :no_content
  end
end