class TypesRepresentations
  def self.index_options
    {
      only: [:name, :id], methods: [:url]
    }
  end

  def self.show_options
    {
      except: [:created_at, :updated_at, :external_id],
      include: {
                 damage_multipliers_from_types: { except: [:id, :to_type_id, :created_at, :updated_at] },
                 damage_multipliers_to_types: { except: [:id, :from_type_id, :created_at, :updated_at] },
                 pokemons: { only: [:id, :name], methods: [:url] }
               }
    }
  end
end