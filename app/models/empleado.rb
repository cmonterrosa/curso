class Empleado < ActiveRecord::Base
  belongs_to :area
  belongs_to :puesto
  def nombre_completo
    "#{paterno} #{materno} #{nombre}"
  end
end
