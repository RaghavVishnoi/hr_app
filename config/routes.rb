Rails.application.routes.draw do


  resources :perf_review_requests
  resources :perf_reviews
  resources :ques_answs
  resources :perf_review_catgs do
    resources :review_catg_quests, only: [:new, :create]
  end

  resources :review_catg_quests, only: [:edit, :update, :destroy]

  resources :events
  root 'home#index'
  resources :project_team_members
  get "/org_team_chart" => "project_team_members#org_team_chart", as: :org_team_chart
  resources :project_teams
  resources :trackers
  resources :projects
  resources :leaves
  resources :issues
  resources :experiences
  resources :employees, except: [:show], path: '/users'
  resources :leave_work_assign
  resources :roles

  devise_for :employees, controllers: {
    sessions: 'employees/sessions',
    registrations: 'employees/registrations',
    passwords: 'employees/passwords',
  }

  devise_for :employee, :controllers => {:sessions => 'sessions'}, :skip => [:sessions] do
    get '/employee/sign_in' => 'sessions#new', :as => :new_emoloyee_session
    post '/employee/sign_in' => 'sessions#create', :as => :employee_session
    get '/employee/sign_out' => 'sessions#destroy', :as => :destroy_employee_session
  end

  get 'leave_requests' => "leave_requests#index"
  get 'home/index'

  get 'home/about'

  get 'home/contact'

  get '/dashboard' => 'dashboard#index', as: :dashboard

  get 'reports/index'
  get 'reports/team_comparision' => "reports#team_comparision", as: :team_comparision
  get 'reports/team_highest_score' => "reports#team_highest_score", as: :team_highest_score
  get 'reports/attemted_vs_passed' => "reports#attemted_vs_passed", as: :attemted_vs_passed
  get 'reports/result_employee_list' => "reports#result_employee_list", as: :report_employee_list
  get 'reports/show_exam_attempte/:employee_id' => "reports#show_exam_attempte", as: :show_exam_attempte
  get 'reports/export_to_csv' => "reports#export_to_csv", as: :export_to_csv

  get 'teams/add_members/:id/:employee_id' => "teams#add_members", as: :add_members
  get 'teams/remove_members/:id/:employee_id' => "teams#remove_members", as: :remove_members
  resources :teams

  resources :subjects
  # get  'results/index' => "results#index", as: :index
  get  'results/exam_result/:exam_id' => "results#exam_result", as: :exam_result
  get  'results/employee_result(/:employee_id)' => "results#employee_result", as: :employee_result
  post 'results/filter_result' => "results#filter_result", as: :filter_result
  get  'results/print/:result' => "results#print", as: :print
  get  'results/activate_result/:exam_id' => "results#activate_result", as: :activate_result
  get  'results/inactivate_result/:exam_id' => "results#inactivate_result", as: :inactivate_result
  get  'results/print_team_result/:team_id' => "results#print_team_result", as: :print_team_result

  post 'questions/complete'

  resources :results
  resources :questions
  resources :exams
  resources :switch_days


  post '/employee_report_show' => "reports#employee_report_show", as: :employee_report_show
  get '/employee_report' => "reports#employee_report", as: :employee_report
  get '/start_tracker_timer' => "trackers#start_tracker_timer", as: :start_tracker_timer
  get '/stop_tracker_timer' => "trackers#stop_tracker_timer", as: :stop_tracker_timer
  get '/employee_projects' => "trackers#employee_projects", as: :employee_projects
  get '/attendance' => "employees#attendance_logs", as: :attendance_logs
  #get '/switch_day' => "employees#switch_day", as: :switch_day
  get '/exam/questions/:exam_id' => "questions#start", as: :exam_start
  post '/question/submit/:q_id' => "questions#save_ans", as: :save_ans
  get '/question/save_ans_by_teacher/:q_id/:employee_id' => "questions#save_ans_by_teacher", as: :save_ans_by_teacher

  resources :documents
  get '/profile/:id' => "employees#show", as: :employee_profile
  post '/upload_document/:id' => "employees#upload_document", as: :upload_document
  get 'download/:id' => "documents#download", as: :download_document
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html'
  get '/gen/send_message' => 'general#send_message', as: :general_send_message
  get '/gen/show_message/:m_id' => 'general#show_message', as: :general_show_message
  get '/gen/new_message' => 'general#new_message', as: :general_new_message
  delete '/gen/delete_message/:m_id' => 'general#delete_message', as: :delete_message


  get '/:id/signatures' => "signatures#index", as: :user_signatures
  post '/save_signature/:id' => "signatures#create", as: :save_signature
  get '/signatures/:id/download' => "signatures#download", as: :download_signature
  delete '/signatures/:id' => "signatures#destroy", as: :delete_signature

  get '/employee_benefits' => 'employee_benefits#index', as: :employee_benefits
  post '/employee_benefits/:id/upload_template' => "employee_benefits#upload_template", as: :upload_template
  get '/download_template/:id' => "employee_benefits#download_emp_benefit_doc", as: :download_emp_benefit_doc
  post '/employee_benefits/:id/upload_benefit_doc' => "employee_benefits#upload_benefit_doc", as: :upload_benefit_doc
  delete '/employee_benefit_docs/:id/destroy' => "employee_benefits#delete_emp_benefit_doc", as: :delete_emp_benefit_doc
  get '/employee_benefit_docs/:id' => "employee_benefits#show", as: :show_emp_benefit_doc

  get '/disclosures' => 'disclosures#index', as: :disclosures
  post '/disclosures/:id/upload_disclosure_template' => "disclosures#upload_disclosure_template", as: :upload_disclosure_template
  get '/download_disc_template/:id' => "disclosures#download_disclosure_doc", as: :download_disclosure_doc
  post '/disclosures/:id/upload_disclosure_doc' => "disclosures#upload_disclosure_doc", as: :upload_disclosure_doc
  delete '/disclosures/:id/destroy' => "disclosures#delete_disclosure_doc", as: :delete_disclosure_doc
  get '/disclosures/:id' => "disclosures#show", as: :show_disclosure_doc

  get '/perf_review_template/new' => 'perf_review_templates#new', as: :new_perf_review_template

  get '/request/:reviewer_id/send_review' => 'perf_reviews#new', as: :give_review

  post '/create_perf_reviews/:reviewer_id' => 'perf_reviews#create', as: :create_perf_reviews

  get '/download_perf_review/:id' => 'perf_reviews#download_pdf', as: :download_pdf

  mount ActionCable.server => "/cable"
end
