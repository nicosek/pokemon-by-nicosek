class CreateDamageTypeMultipliers < ActiveRecord::Migration[7.0]
  def change
    create_table :damage_type_multipliers do |t|
      t.references :from_type, null: false
      t.references :to_type, null: false
      t.float :value

      t.timestamps
    end
    add_foreign_key :damage_type_multipliers, :types, column: :from_type_id
    add_foreign_key :damage_type_multipliers, :types, column: :to_type_id
  end
end
