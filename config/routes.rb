Rails.application.routes.draw do
  resources :posts do
    get '/tagged/:tag' => 'posts#index', :as => 'tagged_with'
    get '/:year(/:month(/:day))' => 'posts#index', :as => 'by_date'
  end

  namespace :admin do 
  end
end
