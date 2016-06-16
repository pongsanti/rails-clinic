Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  #post 'exams_poll', to: 'exams#index_poll'
  post 'qs_poll', to: 'qs#index_poll'
  get 'exams_diags', to: 'exams_diags#index_by_exam'
  post 'exams_diags', to: 'exams_diags#create'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  #resources :users
  #resources :sessions
  resources :customers
  resources :exams
  get 'new_exam_diag/:id', to: 'exams#new_exam_diag', as: 'new_exam_diag'
  post 'update_exam_diag/:id', to: 'exams#update_exam_diag', as: 'update_exam_diag'
  get 'edit_exam_diag/:id', to: 'exams#edit_exam_diag', as: 'edit_exam_diag'

  resources :clients
  resources :qs
  resources :diags  
  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
