BlogApp::Engine.routes.draw do
  get '/admin', to: 'admin#show'

  resources :posts, path: '/', except: :show do
    collection do
      get "/:year(/:month(/:day))" => "posts#for_date", constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ }
      get :search
      get :archive
    end

    member do
      get :podcast_iframe
    end
  end

  namespace :api do
    resources :posts
    resources :authors
    match '/posts/:id', action: :options, controller: 'blog_app/posts', via: :options
  end

  resources :authors, only: :index

  get '/rss', to: 'posts#index', format: "rss"
  get ':slug', to: 'posts#show'

  root to: 'posts#index'
end
