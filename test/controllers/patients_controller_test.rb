require "test_helper"

class PatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient = patients(:one)
  end

  test "should get index" do
    get patients_url
    assert_response :success
  end

  test "should get new" do
    get new_patient_url
    assert_response :success
  end

  test "should create patient" do
    assert_difference('Patient.count') do
      post patients_url, params: { patient: { clinic: @patient.clinic, consent: @patient.consent, email: @patient.email, first_name: @patient.first_name, last_name: @patient.last_name, mobile_number: @patient.mobile_number, procedure_id: @patient.procedure_id, procedure_start_date: @patient.procedure_start_date, program_status: @patient.program_status, referring_clinician: @patient.referring_clinician, response_status: @patient.response_status, return_patient: @patient.return_patient, team_member: @patient.team_member } }
    end

    assert_redirected_to patient_url(Patient.last)
  end

  test "should show patient" do
    get patient_url(@patient)
    assert_response :success
  end

  test "should get edit" do
    get edit_patient_url(@patient)
    assert_response :success
  end

  test "should update patient" do
    patch patient_url(@patient), params: { patient: { clinic: @patient.clinic, consent: @patient.consent, email: @patient.email, first_name: @patient.first_name, last_name: @patient.last_name, mobile_number: @patient.mobile_number, procedure_id: @patient.procedure_id, procedure_start_date: @patient.procedure_start_date, program_status: @patient.program_status, referring_clinician: @patient.referring_clinician, response_status: @patient.response_status, return_patient: @patient.return_patient, team_member: @patient.team_member } }
    assert_redirected_to patient_url(@patient)
  end

  test "should destroy patient" do
    assert_difference('Patient.count', -1) do
      delete patient_url(@patient)
    end

    assert_redirected_to patients_url
  end
end
