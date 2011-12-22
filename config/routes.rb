Cursame::Application.routes.draw do
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
      resources :deliveries, :only => [:index, :show], :module => 'teachers'
    end

    resources :surveys do
      resource :submission, :only => [:show, :new, :create, :edit, :update], :module => 'students'
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
  end

  namespace :supervisor do
    resource :network, :only => [:edit, :update] do
      collection do
        post :upload_logo,  :as => :upload_logo_for
      end
    end
    get :dashboard
    get :teachers
    get :students
    get :pending_approvals
    match '/pending_approvals/:user_id/accept', :as => :accept_user, :action => :accept_user
    match '/pending_approvals/:user_id/reject', :as => :reject_user, :action => :reject_user
  end

  namespace :admin do
    resources :networks
  end
  match '/admin' => 'admin/base#admin'

  resources :comments, :only => [:update, :destroy]
  match '/assignments/:commentable_id/comment', :to => 'comments#create', :as => :comment_assignment, :conditions => {:commentable => :assignment}
  match '/comments/:commentable_id/comment',    :to => 'comments#create', :as => :comment_comment,    :conditions => {:commentable => :comment}
  match '/courses/:commentable_id/comment',     :to => 'comments#create', :as => :comment_course,     :conditions => {:commentable => :course}
  match '/discussions/:commentable_id/comment', :to => 'comments#create', :as => :comment_discussion, :conditions => {:commentable => :discussion}
  match '/users/:commentable_id/comment',       :to => 'comments#create', :as => :comment_user,       :conditions => {:commentable => :user}
  match '/delivery/:commentable_id/comment',    :to => 'comments#create', :as => :comment_delivery,   :conditions => {:commentable => :delivery}

  match '/dashboard', :to => 'home#dashboard', :as => :dashboard
  post  '/upload',    :to => 'assets#upload',  :as => :upload_asset

  root :to => "home#index"
end
