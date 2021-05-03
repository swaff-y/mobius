require "application_system_test_case"

class PatientsTest < ApplicationSystemTestCase
  setup do
    @patient = patients(:one)
  end

  test "visiting the index" do
    visit patients_url
    assert_selector "h1", text: "Patients"
  end

  test "creating a Patient" do
    visit patients_url
    click_on "New Patient"

    fill_in "Clinic", with: @patient.clinic
    check "Consent" if @patient.consent
    fill_in "Email", with: @patient.email
    fill_in "First name", with: @patient.first_name
    fill_in "Last name", with: @patient.last_name
    fill_in "Mobile number", with: @patient.mobile_number
    fill_in "Procedure", with: @patient.procedure_id
    fill_in "Procedure start date", with: @patient.procedure_start_date
    fill_in "Program status", with: @patient.program_status
    fill_in "Referring clinician", with: @patient.referring_clinician
    fill_in "Response status", with: @patient.response_status
    check "Return patient" if @patient.return_patient
    fill_in "Team member", with: @patient.team_member
    click_on "Create Patient"

    assert_text "Patient was successfully created"
    click_on "Back"
  end

  test "updating a Patient" do
    visit patients_url
    click_on "Edit", match: :first

    fill_in "Clinic", with: @patient.clinic
    check "Consent" if @patient.consent
    fill_in "Email", with: @patient.email
    fill_in "First name", with: @patient.first_name
    fill_in "Last name", with: @patient.last_name
    fill_in "Mobile number", with: @patient.mobile_number
    fill_in "Procedure", with: @patient.procedure_id
    fill_in "Procedure start date", with: @patient.procedure_start_date
    fill_in "Program status", with: @patient.program_status
    fill_in "Referring clinician", with: @patient.referring_clinician
    fill_in "Response status", with: @patient.response_status
    check "Return patient" if @patient.return_patient
    fill_in "Team member", with: @patient.team_member
    click_on "Update Patient"

    assert_text "Patient was successfully updated"
    click_on "Back"
  end

  test "destroying a Patient" do
    visit patients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Patient was successfully destroyed"
  end
end
