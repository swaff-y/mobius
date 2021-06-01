class PatientsController < ApplicationController
  before_action :authenticate_user
  before_action :set_patient, only: %i[ show edit update destroy ]
  # skip_before_action :verify_authenticity_token

  # # GET /patients or /patients.json
  # def index
  #   @patients = Patient.all
  # end
  #
  # # GET /patients/1 or /patients/1.json
  # def show
  # end
  #
  # # GET /patients/new
  # def new
  #   @patient = Patient.new
  # end
  #
  # # GET /patients/1/edit
  # def edit
  # end
  #
  # # POST /patients or /patients.json
  # def create
  #   @patient = Patient.new(patient_params)
  #
  #   respond_to do |format|
  #     if @patient.save
  #       format.html { redirect_to @patient, notice: "Patient was successfully created." }
  #       format.json { render :show, status: :created, location: @patient }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @patient.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /patients/1 or /patients/1.json
  # def update
  #   respond_to do |format|
  #     if @patient.update(patient_params)
  #       format.html { redirect_to @patient, notice: "Patient was successfully updated." }
  #       format.json { render :show, status: :ok, location: @patient }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @patient.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /patients/1 or /patients/1.json
  # def destroy
  #   @patient.destroy
  #   respond_to do |format|
  #     format.html { redirect_to patients_url, notice: "Patient was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  def patients_select_clinic
    # params[:clinic_id]
    # params[:team_member_id]
    # params[:sort]
    # params[:direction]

    if params[:team_member_id].present?
      patients = Clinic.find(params[:clinic_id]).patients.where(status:"Active", team_member_id: params[:team_member_id])
    else
      patients = Clinic.find(params[:clinic_id]).patients.where(status: "Active").all
    end

    render json: patients, include: ['procedures','user']
  end

  def patients_all

  end

  def patient_one
    params[:patient_id]
    patient = Patient.where(status: "Active").find(params[:patient_id])
    render json: patient, include: ['procedures','user', 'clinics']
  end

  def create_patient
    # params[:first_name]
    # params[:last_name]
    # params[:mobile_number]
    # params[:return_patient]
    # params[:consent]
    # params[:procedure_start_date]
    # params[:referring_clinician]
    # params[:clinic_id]
    # params[:team_member_id]

    mobile_string = params[:mobile_number].to_s

    mobile_number = []
    mobile_string.split("").each do |char|
      if char.to_i >= 0 && char.to_i <= 9
        mobile_number.push char
      end
    end
    mobile_number = mobile_number.join("").to_s

    clinic = Clinic.where(status: "Active").find(params[:clinic_id])

    patient = Patient.create(
      consent: params[:consent],
      first_name: params[:first_name],
      referring_clinician: params[:referring_clinician],
      last_name: params[:last_name],
      mobile_number: mobile_number,
      procedure_start_date: params[:procedure_start_date],
      program_status: "Active",
      response_status: "No Response",
      return_patient: params[:return_patient],
      team_member_id: params[:team_member_id],
      status: "Active"
    )

    d = DateTime.parse(params[:procedure_start_date])
    date = d.strftime("%Y-%m-%d")

    first_three = []
    second_three = []
    last_four = []
    count = 1
    mobile_number.to_s.split("").each do |char|
      if count >= 1 && count <= 3
        first_three.push char
      elsif count > 3 && count <= 6
        second_three.push char
      else
        last_four.push char
      end
      count += 1
    end

    number = "(" + first_three.join("").to_s + ") " + second_three.join("").to_s + " " + last_four.join("").to_s

    procedure_id = date + "_" + number

    name = params[:first_name] + " " + params[:last_name] + " " + params[:procedure_start_date]

    procedure = Procedure.create(
      description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      name: name,
      procedure_ID: procedure_id
    )

    patient.procedures << procedure
    clinic.procedures << procedure
    patient.clinics << clinic

    render json: patient, include: ['procedures','user']

  end
  def edit_patient
    # params[:first_name]
    # params[:last_name]
    # params[:mobile_number]
    # params[:procedure_start_date]
    # params[:referring_clinician]
    # params[:team_member_id]
    # params[:clinic_id]
    # params[:clinic_old_id]
    # params[:patient_id]
    patient = Patient.find(params[:patient_id])
    clinic = Clinic.find(params[:clinic_id])
    clinic_old = Clinic.find(params[:clinic_old_id])

    patient.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      mobile_number: params[:mobile_number],
      procedure_start_date: params[:procedure_start_date],
      referring_clinician: params[:referring_clinician],
      team_member_id: params[:team_member_id]
    )

    patient.clinics.delete clinic_old

    patient.clinics << clinic

    render json: patient, include: ['procedures','user']
  end

  def delete_patient
    patient = Patient.find(params[:patient_id])
    patient.update(
      status: "Inactive"
    )
    render json: patient
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
