class Types::Update
  DAMAGE_RELATION_NAMES_VALUES_MAPPING = {
    'double_damage' => 2,
    'half_damage' => 0.5,
    'no_damage' => 0
  }

  def initialize
    @poke_api_types = {}
  end

  def call
    new_types = create_types
    create_types_associations(new_types)
  end

  def create_types
    missing_types_external_ids.map do |external_id|
      create_type(external_id)
    end
  end

  def missing_types_external_ids
    poke_api_external_ids = PokeApi::Type.all_external_ids
    existing_types_external_ids = Type.where(external_id: PokeApi::Type.all_external_ids).pluck(:external_id)
    poke_api_external_ids - existing_types_external_ids
  end

  def create_type(external_id)
    poke_api_type = PokeApi::Type.fetch(external_id)
    new_type = Type.create(name: poke_api_type.attributes['name'], external_id: external_id)
    @poke_api_types[new_type.id] = poke_api_type
    new_type
  end

  def create_types_associations(types)
    types.each do |type|
      create_type_associations(type)
    end
  end

  def create_type_associations(type)
    @poke_api_types[type.id].damage_relations.each do |damages_association_name, poke_api_types|
      damage_name, destination = *get_damage_name_and_destination_from_damages_association_name(damages_association_name)
      value = DAMAGE_RELATION_NAMES_VALUES_MAPPING[damage_name]

      poke_api_types.each do |poke_api_type|
        associated_type_id = @poke_api_types[type.id].get_record_id
        next unless associated_type_id.present?

        DamageTypeMultiplier.find_or_create_by(
          from_type_id: (destination == 'from' ? associated_type_id : type.id),
          to_type_id: (destination == 'to' ? associated_type_id : type.id),
          value: value
        )
      end
    end
  end

  def get_damage_name_and_destination_from_damages_association_name(damages_association_name)
    damages_association_name_words = damages_association_name.split('_')
    destination = damages_association_name_words.pop
    damage_name = damages_association_name_words.join('_')
    [damage_name, destination]
  end
end
