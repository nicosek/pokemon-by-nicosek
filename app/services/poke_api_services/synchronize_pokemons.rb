class PokeApiServices::SynchronizePokemons < PokeApiServices::SynchronizeResources
  private

  def active_record_model
    Pokemon
  end

  def params_for_create(poke_api_object)
    {
      name: poke_api_object.attributes['name'],
      base_experience: poke_api_object.attributes['base_experience'],
      height: poke_api_object.attributes['height'],
      weight: poke_api_object.attributes['weight'],
      order: poke_api_object.attributes['order'],
      is_default: poke_api_object.attributes['is_default'],
      pokemon_types_attributes: pokemon_types_attributes(poke_api_object)
    }
  end

  def pokemon_types_attributes(poke_api_object)
    poke_api_object.attributes['types'].map do |type_object|
      type_url = type_object['type']['url']
      type_id = PokeApi::Type.new(url: type_url).get_record_id

      {
        type_id: type_id,
        slot: type_object['slot']
      }
    end
  end
end