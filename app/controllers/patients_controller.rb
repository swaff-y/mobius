class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]

  # GET /patients or /patients.json
  def index
    @patients = Patient.all
  end

  # GET /patients/1 or /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients or /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: "Patient was successfully created." }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: "Patient was successfully updated." }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: "Patient was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def patients_select_clinic
    # params[:clinic_id]
    # params[:team_member_id]
    # params[:sort]
    # params[:direction]

    if params[:team_member_id].present?
      patients = Clinic.find(params[:clinic_id]).team_members.find(params[:team_member_id]).patients.all
    else
      patients = Clinic.find(params[:clinic_id]).patients.all
    end

    render json: patients, include: ['procedures','team_member']
  end

  def patients_all

  end

  def patient_one
    params[:patient_id]
    patient = Patient.find(params[:patient_id])
    render json: patient, include: ['procedures','team_member']
  end

  def create_patient
    params[:first_name]
    params[:last_name]
    params[:mobile_number]
    params[:return_patient]
    params[:consent]
    params[:procedure_start_date]
    params[:GP_referring]
    params[:clinic_id]
    params[:team_member_id]
    params[:email]
  end
  def edit_patient
    params[:first_name]
    params[:last_name]
    params[:mobile]
    params[:date]
    params[:gp]
    params[:radiologist]
    params[:clinic]
    params[:patient_id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:clinic, :consent, :email, :first_name, :referring_clinician, :last_name, :mobile_number, :procedure_id, :procedure_start_date, :program_status, :team_member, :response_status, :return_patient)
    end
end
