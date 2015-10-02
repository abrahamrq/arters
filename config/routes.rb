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
  	get 'artist_request', to: 'requests#new_request', as: :new_artist_request
  	post 'artist_request', to: 'requests#send_request', as: :send_request

    # Just if you are an artist

    # Just if you are an admin
    get 'accept_requests', to: 'requests#index', as: :accept_requests

    # For everyone
  	get 'logout', to: 'sessions#destroy', as: :logout 
	end
end
