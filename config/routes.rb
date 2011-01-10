Rails.application.routes.draw do
  scope "/#{(Spree::Config[:blog_title] || 'blog').to_url}" do
    match "/",                      :to => "posts#index", :as => 'posts'
    match '/tagged/:tag',           :to => 'posts#index', :as => 'posts_by_tag'
    match '/:year(/:month(/:day))', :to => 'posts#index', :as => 'posts_by_date', 
                                                            :year  => /\d{4}/,
                                                            :month => /\d{1,2}/,
                                                            :day   => /\d{1,2}/
    match "/:id",                   :to => "posts#show",  :as => 'post'
  end

  namespace :admin do 
    resources :posts
  end
end
