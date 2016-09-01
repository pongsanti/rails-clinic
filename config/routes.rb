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
  #get 'patient_diags', to: 'patient_diags#index_by_exam'
  #post 'patient_diags', to: 'patient_diags#create'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  #resources :users
  #resources :sessions
  resources :customers do
    resources :exams, only: [:index]
  end
  resources :exams, only: [:show, :destroy]

  get   "customers/:customer_id/exams/new", to: "exams#new_weight",     as: "new_customer_exam_weight"
  post  "customers/:customer_id/exams"    , to: "exams#create_weight",  as: "customer_exam_weight"

  get "edit_exam_weight/:id/edit",  to: "exams#edit_weight",    as: "edit_exam_weight"
  patch "exam_weight/:id",          to: "exams#update_weight",  as: "exam_weight"
  
  get "edit_exam_pe/:id/edit",      to: "exams#edit_pe",        as: "edit_exam_pe"
  patch "exam_pe/:id",              to: "exams#update_pe",      as: "exam_pe"

  get "edit_exam_diag/:id/edit",    to: "exams#edit_diag",      as: "edit_exam_diag"
  patch "exam_diag/:id",            to: "exams#update_diag",    as: "exam_diag" 

  resources :store_units
  resources :drugs do
    resources :drug_ins, shallow: true
  end
  get 'drug_has_drug_ins', to: 'drugs#index_has_drug_ins'

  resources :drug_usages
  resources :drug_movements
  get 'new_patient_diag/:id', to: 'exams#new_patient_diag', as: 'new_patient_diag'
  post 'create_patient_diag/:id', to: 'exams#create_patient_diag', as: 'create_patient_diag'
  patch 'update_patient_diag/:id', to: 'exams#update_patient_diag', as: 'update_patient_diag'
  get 'edit_patient_diag/:id', to: 'exams#edit_patient_diag', as: 'edit_patient_diag'

  get 'exams/:id/drug', to: 'exams#new_exam_drug', as: 'new_exam_drug'
  post 'exams/:id/drug', to: 'exams#create_exam_drug', as: 'create_exam_drug'

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
