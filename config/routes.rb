Rails.application.routes.draw do
  root 'welcome#index'

  # Routes only without session
  scope :constraints => lambda{|req| req.session[:user_id].blank? } do
  	get 'login', to: 'sessions#new', as: :new_login
  	post 'login', to: 'sessions#create', as: :login
  	resources :registration, only: [:new, :create]
	end

	# Routes only with session
  scope :constraints => lambda{|req| !req.session[:user_id].blank? } do
  	# Just if you are a client
    scope :constraints => lambda{|req| req.session[:role] == 'client'} do
    	get 'artist_request', to: 'requests#new_request', as: :new_artist_request
    	post 'artist_request', to: 'requests#send_request', as: :send_request
    end

    # Just if you are an artist
    scope :constraints => lambda{|req| req.session[:role] == 'artist'} do
      get 'upload_item', to: 'items#new', as: :new_item
      post 'upload_item', to: 'items#create', as: :create_item
      get 'my_items', to: 'items#my_items', as: :my_items
      get 'item/:id', to: 'items#show', as: :item
    end

    # Just if you are an admin
    scope :constraints => lambda{|req| req.session[:role] == 'admin'} do
      get 'accept_requests', to: 'requests#index', as: :accept_requests
      post 'change_status', to: 'requests#change_status', as: :change_status
    end
    # For everyone
  	get 'logout', to: 'sessions#destroy', as: :logout 
	end
end
