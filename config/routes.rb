Rails.application.routes.draw do
  scope "/#{(Spree::Config[:blog_title] || 'blog').to_url}" do
    match '/tagged/:tag',           :to => 'posts#index', :as => 'posts_by_tag'
    match '/:year(/:month(/:day))', :to => 'posts#index', :as => 'posts_by_date', 
                                                            :year  => /\d{4}/,
                                                            :month => /\d{1,2}/,
                                                            :day   => /\d{1,2}/
    resources :posts, :path => '/' do
      resources :comments
    end
  end


  namespace :admin do 
    resources :posts do
      resources :comments
    end
    resources :comments
  end
end
