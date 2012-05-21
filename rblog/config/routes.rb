RayindaBlog::Application.routes.draw do

  
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up" 
  
  get "about" => "about", controller: :about, :as => "about" 
  get "contact" => "contact", contoller: :contact, :as => "contact" 

  get "autocomplete_tag_name" => "author/posts#autocomplete_tag_name", :as => "autocomplete_tag_name"
  
  get "search" => "main#search", :as => "search"
  
  resources :sessions, :only => [:new, :create, :destroy]

  root :to => "main#index"
  
  namespace :admin do
    resources :posts, :users, :categories
  end
    
  namespace :user do
    resource :membership_info, only: [:show, :edit, :update], controller: :membership 
    resource :dashboard, only: [:show], controller: :dashboard
  end
  
  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index], controller: :author_posts
  end
  
  namespace :author do
    resources :posts, as: :myposts, controller: :posts do
      get :autocomplete_tag_name, :on => :collection
      resources :comments, only: :destroy
    end
  end
  resources :posts do
    resources :comments
  end
  resources :categories do
    resources :posts, controller: :category_posts, only: [:index, :show]
  end
  namespace :tag do
    resources :posts, only: [:index], controller: :tags
  end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
