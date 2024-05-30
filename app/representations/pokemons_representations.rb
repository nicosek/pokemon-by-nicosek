class PokemonsRepresentations
  def self.show_options
    {
      except: [:created_at, :updated_at, :external_id],
      include: {
                 types: { only: [:id, :name], methods: [:url] }
               }
    }
  end

  def self.index_options
    {
      only: [:name, :id], methods: [:url]
    }
  end
end