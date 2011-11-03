Cursame::Application.routes.draw do
  devise_for :users, :skip => [:registrations]

  with_options :controllers => {:registrations => 'registrations'}, :skip => [:sessions, :passwords, :confirmations, :confirmations] do |opts|  
    opts.devise_for :users, :path => 'maestros', :as => :teacher, :conditions => {:role => :teacher}
    opts.devise_for :users, :path => 'alumnos',  :as => :student, :conditions => {:role => :student}
  end

  resources :courses, :shallow => true do
    collection do
      post :upload_asset, :as => :upload_asset_for
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

    # match '/requests/:id/accept' => 'courses#accept_request', :as => :accept_request, :via => :post
    # match '/requests/:id/reject' => 'courses#reject_request', :as => :reject_request, :via => :post
  end


  match '/dashboard', :to => 'home#dashboard', :as => :dashboard

  root :to => "home#index"
end
