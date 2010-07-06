class EmpleadosController < ApplicationController
  # GET /empleados
  # GET /empleados.xml
  layout 'oficial'
  def index
    @empleados = Empleado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @empleados }
    end
  end

  # GET /empleados/1
  # GET /empleados/1.xml
  def show
    @empleado = Empleado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @empleado }
    end
  end

  # GET /empleados/new
  # GET /empleados/new.xml
  def new
    @empleado = Empleado.new
    @puestos = Puesto.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @empleado }
    end
  end

  # GET /empleados/1/edit
  def edit
    @empleado = Empleado.find(params[:id])
  end

  # POST /empleados
  # POST /empleados.xml
  def create
    @empleado = Empleado.new(params[:empleado])

    respond_to do |format|
      if @empleado.save
        flash[:notice] = 'Empleado was successfully created.'
        format.html { redirect_to(@empleado) }
        format.xml  { render :xml => @empleado, :status => :created, :location => @empleado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empleado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /empleados/1
  # PUT /empleados/1.xml
  def update
    @empleado = Empleado.find(params[:id])

    respond_to do |format|
      if @empleado.update_attributes(params[:empleado])
        flash[:notice] = 'Empleado was successfully updated.'
        format.html { redirect_to(@empleado) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @empleado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /empleados/1
  # DELETE /empleados/1.xml
  def destroy
    @empleado = Empleado.find(params[:id])
    @empleado.destroy

    respond_to do |format|
      format.html { redirect_to(empleados_url) }
      format.xml  { head :ok }
    end
  end

    def live_search
      @empleados = Empleado.find(:all, :conditions => ["nombre like ?  or paterno like ? or materno like ?", "%#{params[:searchtext]}%", "%#{params[:searchtext]}%", "%#{params[:searchtext]}%"])
      return render(:partial => 'filtronombre', :layout => false) if request.xhr?
    end

end
