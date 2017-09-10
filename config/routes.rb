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
#BUG
  get 'bugs/change'
#LOGS
  get 'logs/index'
  post 'logs/index'
#ORIGIN
  root 'origins#index'
  get 'origins/administration', :as => :administration
  get 'origins/bad_boy', :as => :bad_boy
  get 'origins/lists'
  post 'origins/list_empty', :as => :list_empty
#PARTIES
  match '/parties/activate', :to => 'parties#activate', :via => [:get, :post]
  post '/parties/copy'
#SHIRTS
  post 'shirt/:id/download' => 'shirts#download', :as => :shirt_download
  get 'shirts/getImage'
#SHIFTS
  get 'shifts/sortToCouncil'
  post 'shifts/sortToCouncil'
  post 'shifts/insert'
  post 'shifts/remove'
#RESOURCES
  resources :people do
    resources :notes
    resources :statuses
  end
  
  resources :rights
  resources :parties
  resources :councils
  resources :shirts
  resources :bugs
  
  resources :sections do
    resources :shifts
    resources :section_managers
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
