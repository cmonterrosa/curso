class CreatePuestos < ActiveRecord::Migration
  def self.up
    create_table :puestos do |t|
      t.column :puesto, :string
    end

    Puesto.create(:puesto => "Secretario")
    Puesto.create(:puesto => "Subsecretario")

  end

  def self.down
    drop_table :puestos
  end
end
