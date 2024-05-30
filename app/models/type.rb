class Type < ApplicationRecord
  validates_presence_of :name, :external_id

  has_many :pokemon_types
  has_many :pokemons, through: :pokemon_types
  has_many :damage_multipliers_from_types, class_name: 'DamageTypeMultiplier', foreign_key: 'to_type_id', dependent: :destroy
  has_many :damage_multipliers_to_types, class_name: 'DamageTypeMultiplier', foreign_key: 'from_type_id', dependent: :destroy
end
