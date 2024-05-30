class Pokemon < ApplicationRecord
  has_many :pokemon_types
  has_many :types, through: :pokemon_types

  validates_presence_of :name, :external_id, :height, :weight

  accepts_nested_attributes_for :pokemon_types
end
