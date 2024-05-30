require 'rails_helper'

RSpec.describe Type, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :external_id }
  end

  describe 'Associations' do
    it { should have_many(:pokemons).through(:pokemon_types) }
    it { should have_many :damage_multipliers_from_types }
    it { should have_many :damage_multipliers_to_types }
  end
end
