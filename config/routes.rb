Rails.application.routes.draw do
  resources :team_members
  resources :procedures
  resources :pain_scores
  resources :clinics
  resources :patients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/clinic-select-user/' => 'clinics#clinic_select_user'
  get '/clinics-all/' => 'clinics#clinics_all'
  get '/team-members/' => 'team_members#team_members_all'
  get '/patients-select-clinic/' => 'patients#patients_select_clinic'
  get '/clinics-select-patient/' => 'clinics#clinics_select_patients'
  get '/radiologist-select/' => 'team_members#team_member_one'
  get '/radiologist-select-clinic/' => 'team_members#team_member_select_clinic'
  get '/clinic-one/' => 'clinics#clinic_one'
  get '/patients/' => 'patients#patients_all'
  get '/procedure-select/' => 'procedures#procedure_one'
  #list-adder
  #list-adder
  get '/clinics-select-user/' => 'clinics#clinic_select_user'
  get '/team-members-all/' => 'team_members#team_members_all'
  get '/team-member-one/' => 'team_members#team_member_one'
  get '/patient-one/' => 'patients#patient_one'
  get '/pain-scores-select-patient/' => 'pain_scores#pain_scores_select_patient'
  post '/create-patient/' => 'patients#create_patient'
  post '/create-clinic/' => 'clinics#create_clinic'
  post '/edit-patient/' => 'patients#edit_patient'
  post '/edit-clinic/' => 'clinics#edit_clinic'
  delete '/delete-clinic/' => 'clinics#delete_clinic'
end
