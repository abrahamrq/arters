Rails.application.routes.draw do
  root 'welcome#index'

  # Routes only without session
  scope constraints: ->(req) { req.session[:user_id].blank? } do
    get 'login', to: 'sessions#new', as: :new_login
    post 'login', to: 'sessions#create', as: :login
    resources :registration, only: [:new, :create]
  end

  # Routes only with session
  scope constraints: ->(req) { !req.session[:user_id].blank? } do
    # Just if you are a client
    scope constraints: ->(req) { req.session[:role] == 'client' } do
      get 'artist_request', to: 'requests#new_request', as: :new_artist_request
      post 'artist_request', to: 'requests#send_request', as: :send_request
    end

    # Just if you are an artist
    scope constraints: ->(req) { req.session[:role] == 'artist' } do
      get 'upload_item', to: 'items#new', as: :new_item
      post 'upload_item', to: 'items#create', as: :create_item
      get 'my_items', to: 'items#my_items', as: :my_items
      scope constraints: ->(req) { Item.find_by_id(req.env['action_dispatch.request.path_parameters'][:id]).try(:user_id) == req.session[:user_id] && Item.find_by_id(req.env['action_dispatch.request.path_parameters'][:id]).in_stock?} do
        get 'edit_item/:id', to: 'items#edit_item', as: :edit_item
        patch 'edit_item/:id', to: 'items#update_item'
      end
    end

    # User.find(req.session[:user_id]).orders.pluck(:id).include?(req.env['action_dispatch.request.path_parameters'][:id].to_i)
    scope constraints: ->(req) { Order.find_by_id(req.env['action_dispatch.request.path_parameters'][:id]).try(:user_id) == req.session[:user_id]} do
      get 'order/:id', to: 'orders#show', as: :order
    end


    # Just if you are a client or an artist
    scope constraints: ->(req) { ['client', 'artist'].include?(req.session[:role]) } do
      post 'items/add_to_cart', to: 'shopping_cart#add_to_cart',
                                as: :add_to_cart
      post 'items/delete_from_cart', to: 'shopping_cart#delete_from_cart',
                                     as: :delete_from_cart
      get 'my_cart', to: 'shopping_cart#show', as: :my_cart
      get 'checkout', to: 'shopping_cart#check_out', as: :check_out
      post 'checkout', to: 'shopping_cart#create_order'
      get 'my_orders', to: 'orders#index', as: :my_orders
    end

    # Just if you are an admin
    scope constraints: ->(req) { req.session[:role] == 'admin' } do
      get 'accept_requests', to: 'requests#index', as: :accept_requests
      post 'change_status', to: 'requests#change_status', as: :change_status
    end
    # For every role
    get 'logout', to: 'sessions#destroy', as: :logout
  end

  # For everyone
  get 'item/:id', to: 'items#show', as: :item
  get 'items/by_category', to: 'items#index_by_category', as: :items_by_category
  post 'items/by_category', to: 'items#choose_category',
                            as: :choose_category,
                            format: :js
  get 'items/by_artist', to: 'items#index_by_artist', as: :items_by_artist
  post 'items/by_artist', to: 'items#choose_artist',
                          as: :choose_artist,
                          format: :js
end
