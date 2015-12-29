TM::Application.routes.draw do

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "static_pages#home"

  resources :users
  resources :courses
  resources :offerings
  # resources :tutors
  # resources :students
  resources :ratings, :only => [:create]

  resources :sessions, :only => [:new, :create, :destroy]

  resources :favourites, :only => [:index]
  match "/like", :to => 'favourites#create', :via => :post
  match "/unlike", :to => 'favourites#destroy', :via => :delete

  resources :messages, :only => [:index, :show, :new, :create, :destroy]
  match "/messages_all", :to => 'messages#index_all', :via => :get
  match "/read", :to => 'messages#read', :via => :put, :as => :read
  match "/unread", :to => 'messages#unread', :via => :put, :as => :unread
  
  match "/signup", :to => "users#new"
  match "/signin", :to => "sessions#new"
  match "/signout", :to => "sessions#destroy", :via => :delete

  match "/search", :to => "search#index"
  match "/search_results", :to => "search#query"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
