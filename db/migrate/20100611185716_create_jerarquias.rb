class CreateJerarquias < ActiveRecord::Migration
  def self.up
    create_table :jerarquias do |t|
      t.column :nombre, :string
    end
    Jerarquia.create(:nombre=>"Secretaria")
    Jerarquia.create(:nombre=>"Subsecretaria")
    Jerarquia.create(:nombre=>"Coordinacion")
    Jerarquia.create(:nombre=>"Direccion")
    Jerarquia.create(:nombre=>"Sudireccion")
    Jerarquia.create(:nombre=>"Departamento")
  end

  def self.down
    drop_table :jerarquias
  end
end
