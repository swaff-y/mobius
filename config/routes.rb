Rails.application.routes.draw do
  root :to => 'pages#home'
  get 'pages/home'
  # resources :users
  post 'user_token' => 'user_token#create'

  # resources :procedures
  # resources :pain_scores
  # resources :clinics
  # resources :patients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/clinic-select-user/' => 'clinics#clinic_select_user'
  get '/clinic-select-team-member/' => 'clinics#clinic_select_team_member'
  get '/clinics-all/' => 'clinics#clinics_all'
  get '/clinics-user-all/' => 'clinics#clinics_user_all'
  get '/team-members/' => 'users#team_members_all'
  get '/patients-select-clinic/' => 'patients#patients_select_clinic'
  get '/clinics-select-patient/' => 'clinics#clinics_select_patients'
  get '/radiologist-select/' => 'users#team_member_one'
  get '/radiologist-select-clinic/' => 'users#team_member_select_clinic'
  get '/clinic-one/' => 'clinics#clinic_one'
  get '/patients/' => 'patients#patients_all'
  get '/procedure-select/' => 'procedures#procedure_one'
  #list-adder
  #list-adder
  get '/clinics-select-user/' => 'clinics#clinic_select_user'
  get '/team-members-all/' => 'users#team_members_all'
  get '/team-members-all-complete/' => 'users#team_members_all_complete'
  get '/team-members-select-clinic/' => 'users#team_members_select_clinic'
  get '/team-member-one/' => 'users#team_member_one'
  get '/patient-one/' => 'patients#patient_one'
  get '/pain-scores-select-patient/' => 'pain_scores#pain_scores_select_patient'
  get '/pain-scores-one/' => 'pain_scores#pain_scores_one'
  post '/create-patient/' => 'patients#create_patient'
  post '/create-clinic/' => 'clinics#create_clinic'
  post '/create-team-member/' => 'users#create_team_member'
  post '/edit-patient/' => 'patients#edit_patient'
  post '/edit-clinic/' => 'clinics#edit_clinic'
  post '/edit-team-member/' => 'users#edit_team_member'
  post '/edit-team-member-no-clinic/' => 'users#edit_team_member_no_clinic'
  post '/delete-clinic/' => 'clinics#delete_clinic'
  post '/delete-team-member/' => 'users#delete_team_member'
  post '/create-pain-score/' => 'pain_scores#create_pain_score'
  post '/update-pain-score/' => 'pain_scores#update_pain_score'
  post '/update-pain-score-followup/' => 'pain_scores#update_pain_score_followup'
  post '/update-pain-score-responded/' => 'pain_scores#update_pain_score_responded'
  post '/delete-patient/' => 'patients#delete_patient'

  get '/pain-score-graph/' => 'pain_scores#pain_score_graph'


end
