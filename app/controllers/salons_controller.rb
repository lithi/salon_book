class SalonsController < ApplicationController
  before_action :set_salon, only: [:show, :edit, :update, :destroy]

  # GET /salons
  # GET /salons.json
  def index
    @salons = Salon.all
  end

  # GET /salons/1
  # GET /salons/1.json
  def show
  end

  # GET /salons/new
  def new
    @salon = Salon.new
  end

  # GET /salons/1/edit
  def edit
  end

  # POST /salons
  # POST /salons.json
  def create
    @salon = Salon.new(salon_params)

    respond_to do |format|
      if @salon.save
        format.html { redirect_to @salon, notice: 'Salon was successfully created.' }
        format.json { render :show, status: :created, location: @salon }
      else
        format.html { render :new }
        format.json { render json: @salon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salons/1
  # PATCH/PUT /salons/1.json
  def update
    respond_to do |format|
      if @salon.update(salon_params)
        format.html { redirect_to @salon, notice: 'Salon was successfully updated.' }
        format.json { render :show, status: :ok, location: @salon }
      else
        format.html { render :edit }
        format.json { render json: @salon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salons/1
  # DELETE /salons/1.json
  def destroy
    @salon.destroy
    respond_to do |format|
      format.html { redirect_to salons_url, notice: 'Salon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_salon
    @salon = Salon.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def salon_params
    params.require(:salon).permit(:name, :tel, :address, :image, :user_id, { :service_ids => [] })
  end
end
