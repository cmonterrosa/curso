require "pdf/writer"
require 'pdf/simpletable'
require 'date'
require 'iconv'

class AreasController < ApplicationController
  #before_filter :login_required
  layout 'oficial'
  # GET /areas
  # GET /areas.xml
  def index
    @areas = Area.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @areas }
      format.json {render :json => @areas}
    end
  end

  # GET /areas/1
  # GET /areas/1.xml
  def show
    @area = Area.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @area }
    end
  end



  # GET /areas/new
  # GET /areas/new.xml
  def new
    @area = Area.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @area }
    end
  end

  def recorrer
    @area = Area.find(params[:id])
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
  end

  # POST /areas
  # POST /areas.xml
  def create
    @area = Area.new(params[:area])
    @area.parent_id = params[:parent_id]
    respond_to do |format|
      if @area.save
        flash[:notice] = 'Area was successfully created.'
        format.html { redirect_to(@area) }
        format.xml  { render :xml => @area, :status => :created, :location => @area }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @area.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.xml
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        flash[:notice] = 'Area was successfully updated.'
        format.html { redirect_to(@area) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @area.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.xml
  def destroy
    @area = Area.find(params[:id])
    @area.destroy

    respond_to do |format|
      format.html { redirect_to(areas_url) }
      format.xml  { head :ok }
    end
  end

    def get_areas
      @areas= Area.find(:all, :conditions => ["jerarquia_id = ?",params[:_jerarquia_id] ])
      return render(:partial => 'areas', :layout => false) if request.xhr?
    end

  def to_iso(texto)
    c = Iconv.new('ISO-8859-15//IGNORE//TRANSLIT', 'UTF-8')
    iso = c.iconv(texto)
    return iso
  end






    def reporte
     @empleados = Empleado.find(:all, :order => "area_id")
    _pdf = PDF::Writer.new(:paper => "LETTER")
    _pdf.select_font "Times-Roman"
    _pdf.margins_cm(2,2,2,2)
       #--- logos oficiales -----
          i0 = _pdf.image "#{RAILS_ROOT}/public/images/chiapas.png", :resize => 0.45, :justification=>:left
          _pdf.move_pointer(-60)
          i1 = _pdf.image "#{RAILS_ROOT}/public/images/hechos.png", :resize => 0.30, :justification=>:right
          #---- Titulo ----
          _pdf.move_pointer(-90)
          _pdf.text to_iso("Secretaria de Educación"), :font_size => 12, :justification => :center
          _pdf.text to_iso("Coordinación General de Administración Federalizada"), :font_size => 12, :justification => :center
          _pdf.text to_iso("Dirección de Informática"), :font_size => 12, :justification => :center
          _pdf.move_pointer(14)
          _pdf.text to_iso("<b>Directorio de Funcionarios</b>"), :font_size => 11, :justification => :center
          #_pdf.move_pointer(10)

          #------ Ordenamos las areas por jerarquia ----------
          areas=[]
            @superarea = Area.find(:first, :conditions => "parent_id is NULL")

              for hijo in @superarea.children
                  for nieto in hijo.children
                      for bisnieto in nieto.children
                          areas << bisnieto
                      end
                      areas << nieto
                  end
                  areas << hijo
              end
               #--- Involucramos a los que dependen de la secretaria es decir del padre ---
               areas << @superarea
               areas = areas.reverse
               empleados_array = []

              #--- iteracion por cada una de los areas ---
                 for area in areas
                   #----- Validamos si el area tiene empleados asociados -------
                   if area.empleados.size > 0
                      _pdf.move_pointer(15)
                      _pdf.text to_iso(area.nombre), :font_size => 14, :justification => :center
                      _pdf.move_pointer(15)
                   end
                   
                    for empleado in Empleado.find(:all, :conditions => ["area_id = ?", area.id], :order => "puesto_id")
                          empleados_array = []
                          PDF::SimpleTable.new do |tab|
                               tab.column_order.push(*%w(nombre puesto telefono correo))
                               tab.font_size=11
                               tab.heading_font_size=10
                               tab.bold_headings = true
                               tab.show_headings = false
                               tab.width=450
                               tab.show_lines =:all
                               #----------------- Columnas --------------------
                               tab.columns["nombre"] = PDF::SimpleTable::Column.new("nombre") { |col|  col.width=180 }
                               tab.columns["puesto"] = PDF::SimpleTable::Column.new('puesto') { |col|   col.width=100  }
                               tab.columns["telefono"] = PDF::SimpleTable::Column.new('telefono') { |col|   col.width=50  }
                               tab.columns["correo"] = PDF::SimpleTable::Column.new('correo') { |col|   col.width=120  }
                               tab.show_lines    = :false
                               tab.orientation   = :center
                               tab.position      = :center
                               tab.shade_color = Color::RGB::White

                               empleados_array << {"nombre" => to_iso(empleado.nombre_completo),
                                                   "puesto" => to_iso(empleado.puesto.puesto),
                                                   "telefono" => to_iso(empleado.telefono),
                                                   "correo" => to_iso(empleado.correo)
                                                  }
                               tab.data.replace empleados_array
                               tab.render_on(_pdf)
                               end
                                #_pdf.move_pointer(5)
                       
                        end
                          
                 end
     send_data _pdf.render, :filename => "directorio.pdf",
                            :type => "application/pdf"

    end




    def xml
      #------ Ordenamos las areas por jerarquia ----------
      datos=[]
        @superarea = Area.find(:first, :conditions => "parent_id is NULL")
               for hijo in @superarea.children
                  for nieto in hijo.children
                      for bisnieto in nieto.children
                          for empleado in Empleado.find(:all, :conditions => ["area_id = ?", bisnieto.id], :order => "puesto_id DESC")
                            datos << {"nombre" => empleado.nombre_completo, "puesto" => empleado.puesto.puesto, "area" => empleado.area.nombre, "telefono" => empleado.telefono, "correo" => empleado.correo, "jerarquia" => empleado.puesto.id}
                          end
                      end
                      for empleado in Empleado.find(:all, :conditions => ["area_id = ?", nieto.id], :order => "puesto_id DESC")
                        datos << {"nombre" => empleado.nombre_completo,  "puesto" => empleado.puesto.puesto, "area" => empleado.area.nombre, "telefono" => empleado.telefono, "correo" => empleado.correo, "jerarquia" => empleado.puesto.id}
                      end
                  end
                  for empleado in Empleado.find(:all, :conditions => ["area_id = ?", hijo.id], :order => "puesto_id DESC")
                        datos << {"nombre" => empleado.nombre_completo,  "puesto" => empleado.puesto.puesto, "area" => empleado.area.nombre, "telefono" => empleado.telefono, "correo" => empleado.correo, "jerarquia" => empleado.puesto.id}
                  end
               end
               #--- Involucramos a los que dependen de la secretaria es decir del padre ---
               for empleado in @superarea.empleados
                   datos << {"nombre" => empleado.nombre_completo, "puesto" => empleado.puesto.puesto, "area" => empleado.area.nombre, "telefono" => empleado.telefono, "correo" => empleado.correo, "jerarquia" => empleado.puesto.id}
               end

        render :xml => datos.reverse.to_xml
     end





end
