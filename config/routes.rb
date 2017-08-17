Rails.application.routes.draw do

#JUDGE
  get 'judges/index'
  get 'judges/init'
  get 'judges/change'
  get 'judges/change_controller'
#RIGHT
  get 'rights/change'
#PERSON
  post 'people/:id/change_status', :to => 'people#change_status', :as => :change_status
  
#ORIGIN
  root 'origins#index'
  get 'origins/administration', :as => :administration
  get 'origins/bad_boy', :as => :bad_boy
#PARTIES
  match '/parties/activate', :to => 'parties#activate', :via => [:get, :post]
  post '/parties/copy'
#RESOURCES
  resources :people do
    resources :notes
    resources :statuses
  end
  
  resources :rights
  resources :parties
  resources :councils
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
