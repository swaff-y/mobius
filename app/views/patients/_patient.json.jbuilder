json.extract! patient, :id, :clinic, :consent, :email, :first_name, :referring_clinician, :last_name, :mobile_number, :procedure_id, :procedure_start_date, :program_status, :team_member, :response_status, :return_patient, :created_at, :updated_at
json.url patient_url(patient, format: :json)
