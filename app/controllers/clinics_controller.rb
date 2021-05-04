class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /clinics or /clinics.json
  def index
    @clinics = Clinic.all
  end

  # GET /clinics/1 or /clinics/1.json
  def show
  end

  # GET /clinics/new
  def new
    @clinic = Clinic.new
  end

  # GET /clinics/1/edit
  def edit
  end

  # POST /clinics or /clinics.json
  def create
    @clinic = Clinic.new(clinic_params)

    respond_to do |format|
      if @clinic.save
        format.html { redirect_to @clinic, notice: "Clinic was successfully created." }
        format.json { render :show, status: :created, location: @clinic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinics/1 or /clinics/1.json
  def update
    respond_to do |format|
      if @clinic.update(clinic_params)
        format.html { redirect_to @clinic, notice: "Clinic was successfully updated." }
        format.json { render :show, status: :ok, location: @clinic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinics/1 or /clinics/1.json
  def destroy
    @clinic.destroy
    respond_to do |format|
      format.html { redirect_to clinics_url, notice: "Clinic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def clinic_select_user
    params[:useR]
  end

  def clinics_all
    clinics = Clinic.all
    render json: clinics, include: ['team_members']
  end

  def clinic_one
    # params[:clinic_id]
    clinic = Clinic.find(params[:clinic_id])
    render json: clinic
  end

  def clinic_select_user
    params[:user_id]
  end

  def create_clinic
    # params[:name]
    # params[:address]
    clinic = Clinic.create(
      name: params[:name],
      address: params[:address]
    )

    render json: clinic
  end

  def edit_clinic
    # params[:name]
    # params[:address]
    # params[:clinic_id]
    clinic = Clinic.find(params[:clinic_id])

    clinic.update(
      name: params[:name],
      address: params[:address]
    )

    render json: clinic
  end

  def delete_clinic
    # params[:name]
    # params[:address]
    # params[:clinic_id]
    clinic = Clinic.find(params[:clinic_id])
    render json: clinic
    clinic.destroy
  end

  def clinics_select_patients
      # params[:clinic_id]
      # params[:radiologist_id]
      # params[:sort]
      # params[:direction]
      clinics = Patient.find(params[:patient_id]).clinics.all
      render json: clinics
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def clinic_params
      params.require(:clinic).permit(:address, :name)
    end
end
