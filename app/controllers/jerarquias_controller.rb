class JerarquiasController < ApplicationController
  # GET /jerarquias
  # GET /jerarquias.xml
  def index
    @jerarquias = Jerarquia.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jerarquias }
    end
  end

  # GET /jerarquias/1
  # GET /jerarquias/1.xml
  def show
    @jerarquia = Jerarquia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jerarquia }
    end
  end

  # GET /jerarquias/new
  # GET /jerarquias/new.xml
  def new
    @jerarquia = Jerarquia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jerarquia }
    end
  end

  # GET /jerarquias/1/edit
  def edit
    @jerarquia = Jerarquia.find(params[:id])
  end

  # POST /jerarquias
  # POST /jerarquias.xml
  def create
    @jerarquia = Jerarquia.new(params[:jerarquia])

    respond_to do |format|
      if @jerarquia.save
        flash[:notice] = 'Jerarquia was successfully created.'
        format.html { redirect_to(@jerarquia) }
        format.xml  { render :xml => @jerarquia, :status => :created, :location => @jerarquia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jerarquia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jerarquias/1
  # PUT /jerarquias/1.xml
  def update
    @jerarquia = Jerarquia.find(params[:id])

    respond_to do |format|
      if @jerarquia.update_attributes(params[:jerarquia])
        flash[:notice] = 'Jerarquia was successfully updated.'
        format.html { redirect_to(@jerarquia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jerarquia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jerarquias/1
  # DELETE /jerarquias/1.xml
  def destroy
    @jerarquia = Jerarquia.find(params[:id])
    @jerarquia.destroy

    respond_to do |format|
      format.html { redirect_to(jerarquias_url) }
      format.xml  { head :ok }
    end
  end
end
