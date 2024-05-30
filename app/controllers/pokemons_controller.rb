class PokemonsController < ApplicationController
  # GET /pokemons
  def index
    render json: Pokemon.all.to_json(PokemonsRepresentations.index_options)
  end

  # GET /pokemons/1
  def show
    render json: pokemon.to_json(PokemonsRepresentations.show_options)
  end

  private

  def pokemon
    @pokemon ||= Pokemon.find(params[:id])
  end
end
