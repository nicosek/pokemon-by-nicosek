class PokeApiServices::SynchronizeTypes < PokeApiServices::SynchronizeResources
  DAMAGE_RELATION_NAMES_VALUES_MAPPING = {
    'double_damage' => 2,
    'half_damage' => 0.5,
    'no_damage' => 0
  }

  def initialize
    super
    @poke_api_objects = {}
  end

  def call
    super
    create_types_associations
  end

  private

  def active_record_model
    Type
  end

  def params_for_create(poke_api_object)
    {
      name: poke_api_object.attributes['name']
    }
  end

  def create_record(external_id)
    new_record, poke_api_object = *super
    @poke_api_objects[new_record.id] = poke_api_object
  end

  def create_types_associations
    @poke_api_objects.each do |type_id, poke_api_type|
      create_type_associations(type_id: type_id, poke_api_type: poke_api_type)
    end
  end

  def create_type_associations(type_id:, poke_api_type:)
    poke_api_type.damage_relations.each do |damages_association_name, associated_types_params|
      damage_name, destination = *get_damage_name_and_destination_from_damages_association_name(damages_association_name)
      value = DAMAGE_RELATION_NAMES_VALUES_MAPPING[damage_name]

      associated_types_params.each do |associated_type_params|
        associated_type_id = PokeApi::Type.new(url: associated_type_params['url'])
                                          .get_record_id
        next unless associated_type_id.present?

        DamageTypeMultiplier.find_or_create_by(
          from_type_id: (destination == 'from' ? associated_type_id : type_id),
          to_type_id: (destination == 'to' ? associated_type_id : type_id),
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