Cursame::Application.routes.draw do
  
  get "analytics/users"
  get "analytics/devices"
  get "analytics/visits_by_date"
  get "analytics/visits_by_hour"
  get "analytics/logins"
  get "analytics/posts"
  get "analytics/most_commented_posts"

  resources :accepted_terms

  resources :new_users_change_types

  resources :notificaciones_admin_actualice

  resources :tutoriales

  resources :favorites
  
  resources :status_courses
  #networks gets
  get "networks/network_cc"
  get "networks/instrucciones"
  
  resources :networks
  
  resources :statuses

  resources :bug_answers

  resources :send_reports

  resources :comment_posts

  resources :blogs

  resources :like_not_likes

  resources :calendar_activities
  resources :chats
  resources :calificationems
  devise_for :users do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  devise_for :users, :skip => [:registrations]
  with_options :controllers => {:registrations => 'registrations'}, :skip => [:sessions, :passwords, :confirmations, :confirmations] do |opts|  
    opts.devise_for :users, :path => 'maestros', :as => :teacher, :conditions => {:role => :teacher}
    opts.devise_for :users, :path => 'alumnos',  :as => :student, :conditions => {:role => :student}
  end

  resources :courses, :shallow => true do
    collection do
      post :upload_logo,  :as => :upload_logo_for
    end

    member do
      get  'miembros', :as => :members_for, :to => 'courses#members'
      get  'muro',     :as => :wall_for,    :to => 'courses#wall'
      get  'calification',     :as => :calification_for, :to => 'courses#calification'
    end

    resources :assignments, :shallow => true do
      resource :delivery, :only => [:show, :new, :create, :edit, :update], :module => 'students'
      resources :deliveries, :only => [:index, :show, :create], :module => 'teachers'
    end

    resources :surveys, :shallow => true do
      member do
        put :publish
      end
      resource :survey_reply, 
        :as => :reply, 
        :only => [:show, :new, :create, :edit, :update],
        :module => 'students'
      resources :survey_replies, :as => :replies, :only => [:index, :show], :module => 'teachers'
    end

    resources :discussions
    resources :requests, :only => [:create, :index], :controller => 'course_requests' do
      member do
        post :accept
        post :reject
      end
    end
  end

  resources :users do
    collection do
      #crear una ruta create_user, cabiaste el form y el filter y cambiar a la accion create user
      post :create_user
      post :upload_avatar,  :as => :upload_avatar_for
    end
    member do
     
      get  'muro', :as => :wall_for, :to => 'users#wall'
    end
     
    
  end

  resource :settings, :only => [:show] do
    put :password
    put :notifications
  end

  namespace :supervisor do
    resource :network, :only => [:edit, :update] do
      collection do
        post :upload_logo,  :as => :upload_logo_for
      end
    end
    get :new_user
    get :dashboard
    get :teachers
    get :students
    get :supervisors
    get :pending_approvals
    get :import_users
    get :analytics
    post :import_csv
    match '/pending_approvals/:user_id/accept', :as => :accept_user, :action => :accept_user
    match '/pending_approvals/:user_id/reject', :as => :reject_user, :action => :reject_user
  end

  namespace :admin do
    resources :networks
    get '/statistics', :to => 'base#statistics', :as => :statistics
    get '/reports', :to => 'base#reports', :as => :reports
    get '/potence-tutorial', :to => 'base#tutorials', :as => :tutorial
    get '/public-notification', :to => 'base#notification', :as => :notification
  end

  match '/admin' => 'admin/base#admin'

  resources :comments, :only => [:update, :destroy, :show, :like_comments]
  match '/assignments/:commentable_id/comment', :to => 'comments#create', :as => :comment_assignment, :conditions => {:commentable => :assignment}
  match '/comments/:commentable_id/comment',    :to => 'comments#create', :as => :comment_comment,    :conditions => {:commentable => :comment}
  match '/courses/:commentable_id/comment',     :to => 'comments#create', :as => :comment_course,     :conditions => {:commentable => :course}
  match '/discussions/:commentable_id/comment', :to => 'comments#create', :as => :comment_discussion, :conditions => {:commentable => :discussion}
  match '/users/:commentable_id/comment',       :to => 'comments#create', :as => :comment_user,       :conditions => {:commentable => :user}
  match '/delivery/:commentable_id/comment',    :to => 'comments#create', :as => :comment_delivery,   :conditions => {:commentable => :delivery}
  match '/network/:commentable_id/comment', :to => 'comments#create',:as => :comment_network,    :conditions => {:commentable => :network}
  #cambio del principal por el dashboard
     #get'/network/:id', :to => 'networks#relate', :as => :relate_wall
     #match '/network/:id/wall', :to =>'networks#principal_wall', :as => :principal_wall
      match '/network-wall', :to =>'networks#principal_wall', :as => :principal_wall
  #routes basics home   
  #el dasboard se mantien como ruta principal en el el home para al free
  match '/dashboard', :to => 'home#dashboard', :as => :dashboard
  match '/terminos', :to => 'home#terms', :as => :terms
  match '/privacidad', :to => 'home#privacidad', :as => :privacidad
  #match '/aceptacion_de_uso', :to => 'users#acept_terms_and_conditions', :as => :terms_condition_acepted
   match '/ayuda', :to => 'home#help', :as => :help
   match '/ayuda/tareas', :to => 'home#helpers/tareas', :as => :help_tareas
   match '/ayuda/cursos', :to => 'home#helpers/curso', :as => :help_cursos
   match '/ayuda/cuestionarios', :to => 'home#helpers/cuestionarios', :as => :help_cuestionarios
   match '/ayuda/discusion', :to => 'home#helpers/discusion', :as => :help_discusiones
   match '/ayuda/calendario', :to => 'home#helpers/calendario', :as => :help_calendario
   match '/ayuda/notificaciones', :to => 'home#helpers/notificaciones', :as => :help_notificaciones
   match '/ayuda/calificaciones', :to => 'home#helpers/calificaciones', :as => :help_calificaciones
   #this is the abstract to new network
   match '/nueva-red', :to => 'networks#network_cc', :as => :network_cc
   match '/nueva-red/instrucciones', :to => 'networks#instrucciones', :as => :instrucciones_red   
   #fin
   #user favorites 
   match 'my_favorites', :to => 'favorites#my_favorite_users', :as => :my_favorite_users   
   #fin
  match  '/blog', :to => 'home#blog/blog', :as => :blog
   match  '/blog/newpost', :to => 'home#blog/new_post', :as => :blog_new
  match  '/nosotros', :to => 'home#nosotros', :as => :nosotros
  match  '/soporte', :to => 'home#reports', :as => :soporte
  match  '/discant_homines/quam_docere/viri_fratres/terris', :to => 'home#new_admin', :as => "new_admin"
  match  'supervisor/suspended/users', :to => 'supervisor#suspended', :as => :user_suspended
  get '/calendar', :to => 'home#dashboard_calendar', :as => :calendar
  get '/members', :to => 'home#members', :as => :network_members
  post  '/upload',    :to => 'assets#upload',  :as => :upload_asset
  post '/create', :to => 'assets#create', :as => :create_asset
  
  
  
  root :to => "home#index"
  
  #this is for api for the mobile app
  namespace :api do
    resources :tokens,:only => [:create, :destroy]
  end  
  match '/api/tokens/create', :to => 'api/tokens#create', :as => :login
  match '/api/api/users', :to => 'api/api#users', :as => :usersjson
  match '/api/api/courses', :to => 'api/api#courses', :as => :coursesjson
  match '/api/api/assignments', :to => 'api/api#assignments', :as => :assignmentsjson
  match '/api/api/surveys', :to => 'api/api#surveys', :as => :surveysjson
  match '/api/api/discussions', :to => 'api/api#discussions', :as => :discussionsjson
  match '/api/api/notifications', :to => 'api/api#notifications', :as => :notificationsjson
  
  
  match '/api/api/course_requests', :to => 'api/api#course_requests', :as => :course_requestsjson
  match '/api/api/comments', :to => 'api/api#comments', :as => :commentsjson
  match '/api/api/update_course', :to => 'api/api#update_course', :as => :update_course
  match '/api/api/create_comment', :to => 'api/api#create_comment', :as => :create_comment
  match '/api/api/create_like', :to => 'api/api#create_like', :as => :create_like
  match '/api/api/questions', :to => 'api/api#questions', :as => :questions
  match '/api/api/survey_replies', :to => 'api/api#survey_replies', :as => :survey_replies
end
