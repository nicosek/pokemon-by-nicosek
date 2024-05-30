module PokeApi
  class Pokemon < Resource
    def self.type
      'pokemon'
    end

    def self.expected_attributes
      %w[name base_experience height weight order is_default types]
    end
  end
end
