require 'rails_helper'

RSpec.describe "TypesControllers", type: :request do
  let!(:type) { Type.create(name: 'fighting', external_id: 1) }
  let(:json_response) { JSON.parse(response.body) }

  describe "GET /index" do
    before { get types_path, as: :json }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders json types list with one element' do
      expect(json_response.count).to eq 1
      expect(json_response).to include(
        {
          'id' => type.id,
          'name' => type.name,
          'url' => end_with(type_path(id: type.id))
        }
      )
    end
  end

  describe "GET /show" do
    before do
      pokemon_type
      damage_multiplier_from_type
      get type_path(id: type.id), as: :json
    end

    let(:pokemon) { Pokemon.create(name: 'Jean', external_id: 3, height:2, weight: 4) }
    let(:pokemon_type) { PokemonType.create(slot: 1, pokemon: pokemon, type: type) }
    let(:other_type) { Type.create(name: 'cooking', external_id: 2) }
    let(:damage_multiplier_from_type) { DamageTypeMultiplier.create(from_type_id: other_type.id, to_type_id: type.id, value: 2 ) }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders json type with associated pokemons' do
      expect(json_response).to include(
        {
          'id' => type.id,
          'name' => type.name,
          'damage_multipliers_from_types' => [{"from_type_id" => other_type.id, "value"=>2.0}],
          'damage_multipliers_to_types' => [],
          'pokemons' => [
                          {
                            "id" => pokemon.id,
                            "name" => pokemon.name,
                            "url" => end_with(pokemon_path(id: pokemon.id))
                          }
                        ]
        }
      )
    end
  end
end
