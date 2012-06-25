ClinicManagerExtension::Application.routes.draw do

  devise_for :users
  resources :users

  resources :referrals do
    get :autocomplete_person_full_name, :on => :collection
    get :followers_suggestions, :on => :collection
    get :cancel, :on => :member
    get :accept_declination_and_close, :on => :member
  end

  resources :appointments do
    get :confirm_appointment, :on => :member, :as => "confirm"
    get :calendar_data, :on => :member
    post :calendar_update_date, :on => :member
  end

  resources :people do
    get 'page/:page', :action => :index, :on => :collection
  end
# resources :documents
  match 'documents/:fingerprint/download' => 'documents#download', :as => :download
  match "notifications/read/:id" => "notifications#read"
  match "notifications" => "notifications#index"

  root :to => "users#dashboard"
end
