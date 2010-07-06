class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.column :nombre, :string
      t.column :extension_digital, :string, :limit=>10
      t.column :extension_analogica, :string, :limit => 10
      t.column :email, :string, :limit => 30
      t.column :tel_directo, :string
      t.column :area, :string, :limit=>30
      t.column :jerarquia_id, :integer
      t.column :parent_id, :integer
    end
end

  def self.down
    drop_table :areas
  end
end
