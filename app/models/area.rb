class Area < ActiveRecord::Base
  acts_as_tree :order => "nombre"
  has_many :empleados
  belongs_to :jerarquia
end
