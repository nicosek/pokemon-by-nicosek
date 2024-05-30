class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :external_id
      t.integer :base_experience
      t.integer :height
      t.integer :weight
      t.integer :order
      t.boolean :is_default

      t.timestamps
    end
  end
end
