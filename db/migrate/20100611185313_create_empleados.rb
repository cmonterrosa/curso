class CreateEmpleados < ActiveRecord::Migration
  def self.up
    create_table :empleados do |t|
      t.column :paterno, :string, :limit=>40
      t.column :materno, :string, :limit=>40
      t.column :nombre, :string, :limit=>60
      t.column :telefono, :string, :limit=>10
      t.column :correo, :string, :limit=>40
      t.column :puesto_id, :integer
      t.column :area_id, :integer
    end
  end

  def self.down
    drop_table :empleados
  end
end
