module PokeApi
  class Type < Resource
    def self.type
      'type'
    end

    def self.expected_attributes
      %w[name damage_relations]
    end

    def damage_relations
      attributes['damage_relations']
    end
  end
end
