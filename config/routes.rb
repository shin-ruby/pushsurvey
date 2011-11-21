Proedm::Application.routes.draw do

  get "confirmation/confirmation"

  resources :folders

  resources :categories

  resources :pushes do
    get :export, :on => :member
    match :start, :on => :member
    match :show_data, :on => :member
  end

  resources :designs do
    get :preview, :on => :member
    get :save, :on => :member
  end
  resources :address_books do
    get :export, :on => :member
    match :import, :on => :member
    get :show_data, :on => :member
  end

  resources :user do
    get :show_current, :on => :collection
    get :edit_password,:on => :collection

  end
  resources :collect do
    get :show_current, :on => :collection
    get :edit_password,:on => :collection

  end

  resources :contacts

  resources :events do
    match 'postback',:on => :collection
  end

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "admin/index"

  devise_for :users, :controllers => {:sessions => "sessions"}

  get "home/index"

  match "confirmation/confirmation", :as => "confirmation"
  match "confirmation/back", :as => "back"



  #namespace :admin do
  #  root :to => "admin#index"
  #  resources :posts, :comments
  #end

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"
  root :to => "pushes#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
