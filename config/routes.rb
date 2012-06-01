Cursame::Application.routes.draw do
  
  get "calificationem/form"

  resources :chats
  resources :calificationems
  
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
    post :import_csv
    match '/pending_approvals/:user_id/accept', :as => :accept_user, :action => :accept_user
    match '/pending_approvals/:user_id/reject', :as => :reject_user, :action => :reject_user
  end

  namespace :admin do
    resources :networks
    get '/statistics', :to => 'base#statistics', :as => :statistics
  end

  match '/admin' => 'admin/base#admin'

  resources :comments, :only => [:update, :destroy, :show]
  match '/assignments/:commentable_id/comment', :to => 'comments#create', :as => :comment_assignment, :conditions => {:commentable => :assignment}
  match '/comments/:commentable_id/comment',    :to => 'comments#create', :as => :comment_comment,    :conditions => {:commentable => :comment}
  match '/courses/:commentable_id/comment',     :to => 'comments#create', :as => :comment_course,     :conditions => {:commentable => :course}
  match '/discussions/:commentable_id/comment', :to => 'comments#create', :as => :comment_discussion, :conditions => {:commentable => :discussion}
  match '/users/:commentable_id/comment',       :to => 'comments#create', :as => :comment_user,       :conditions => {:commentable => :user}
  match '/delivery/:commentable_id/comment',    :to => 'comments#create', :as => :comment_delivery,   :conditions => {:commentable => :delivery}

  match '/dashboard', :to => 'home#dashboard', :as => :dashboard
  match '/terminos', :to => 'home#terms', :as => :terms
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
end
