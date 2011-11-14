ClinicManagerExtension::Application.routes.draw do
  
  devise_for :users

  resources :referrals do
    get :autocomplete_person_full_name, :on => :collection
    get :followers_suggestions, :on => :collection
    get :cancel, :on => :member
  end
  
  resources :appointments do
    get :confirm_appointment, :on => :member, :as => "confirm"
    get :calendar_data, :on => :member
    post :calendar_update_date, :on => :member
  end
  
  resources :people do
    get 'page/:page', :action => :index, :on => :collection
  end
  
  root :to => "referrals#index"
end
