Rails.application.routes.draw do

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

  mount ActionCable.server => "/cable"
end
