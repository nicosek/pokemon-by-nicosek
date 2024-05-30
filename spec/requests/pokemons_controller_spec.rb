require 'rails_helper'

RSpec.describe "PokemonsControllers", type: :request do
  let!(:pokemon) { Pokemon.create(name: 'Jean', external_id: 3, height:2, weight: 4) }
  let(:json_response) { JSON.parse(response.body) }

  describe "GET /index" do
    before { get pokemons_path, as: :json }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders json types list with one element' do
      expect(json_response.count).to eq 1
      expect(json_response).to include(
        {
          'id' => pokemon.id,
          'name' => pokemon.name,
          'url' => end_with(pokemon_path(id: pokemon.id))
        }
      )
    end
  end

  describe "GET /show" do
    before do
      pokemon_type
      get pokemon_path(id: pokemon.id), as: :json
    end

    let(:type) { Type.create(name: 'cooking', external_id: 2) }
    let(:pokemon_type) { PokemonType.create(slot: 1, pokemon: pokemon, type: type) }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders json type with associated pokemons' do
      expect(json_response).to include(
        {
          'id' => pokemon.id,
          'name' => pokemon.name,
          'types' => [
                          {
                            "id" => type.id,
                            "name" => type.name,
                            "url" => end_with(type_path(id: type.id))
                          }
                        ]
        }
      )
    end
  end
end
