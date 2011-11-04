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
      get  :members
    end

    resources :assignments
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
  end


  namespace :admin do
    resources :networks
  end
  match '/admin' => 'admin/base#admin'


  resources :comments, :only => [:update, :destroy]
  match '/assignments/:commentable_id/comment', :to => 'comments#create', :as => :comment_assignment, :conditions => {:commentable => :assignment}

  match '/dashboard', :to => 'home#dashboard', :as => :dashboard
  post  '/upload',    :to => 'assets#upload',  :as => :upload_asset
  root :to => "home#index"
end
