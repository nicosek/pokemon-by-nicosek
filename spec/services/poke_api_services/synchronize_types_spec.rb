require 'rails_helper'

RSpec.describe PokeApiServices::SynchronizeTypes, type: :service do
  describe '#call' do
    let(:type_name_1) { 'normal' }
    let(:type_name_2) { 'fighting' }
    let(:external_id_1) { 1 }
    let(:external_id_2) { 2 }
    let(:poke_api_object_1) { double('PokeApi::Type') }
    let(:poke_api_object_2) { double('PokeApi::Type') }
    let(:poke_api_object_1_attributes) do
      {
        "name" => type_name_1,
        "damage_relations" => {
          "double_damage_from" => [{"name" => type_name_2, "url" => "https://pokeapi.co/api/v2/type/#{external_id_2}/"}],
          "double_damage_to" => []
        }
      }
    end

    let(:poke_api_object_2_attributes) do
      {
        "name" => type_name_2,
        "damage_relations" => {
          "double_damage_from" => [],
          "double_damage_to" => [{"name" => type_name_1, "url" => "https://pokeapi.co/api/v2/type/#{external_id_1}/"}]
        }
      }
    end

    subject { described_class.new }

    before do
      allow(PokeApi::Type).to receive(:all_external_ids) { [external_id_1, external_id_2] }
      allow(PokeApi::Type).to receive(:fetch).with(external_id_1) { poke_api_object_1 }
      allow(PokeApi::Type).to receive(:fetch).with(external_id_2) { poke_api_object_2 }

      allow(poke_api_object_1).to receive(:attributes) { poke_api_object_1_attributes }
      allow(poke_api_object_2).to receive(:attributes) { poke_api_object_2_attributes }
      allow(poke_api_object_1).to receive(:damage_relations) { poke_api_object_1_attributes['damage_relations'] }
      allow(poke_api_object_2).to receive(:damage_relations) { poke_api_object_2_attributes['damage_relations'] }
    end

    it 'should seed the database with new entries' do
      subject.call

      expect(Type.count).to eq 2
      
      type_1 = Type.find_by(external_id: external_id_1)
      type_2 = Type.find_by(external_id: external_id_2)

      expect(type_1).to have_attributes(name: type_name_1)
      expect(type_1.damage_multipliers_from_types.size).to eq 1
      expect(type_1.damage_multipliers_from_types.first).to have_attributes(
        from_type_id: type_2.id,
        to_type_id: type_1.id,
        value: PokeApiServices::SynchronizeTypes::DAMAGE_RELATION_NAMES_VALUES_MAPPING['double_damage']
      )
    end
  end
end