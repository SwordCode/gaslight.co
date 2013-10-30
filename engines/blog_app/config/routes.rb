BlogApp::Engine.routes.draw do
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

  resources :authors, only: :index

  get ':slug', to: 'posts#show'
  get 'post/:id(/:slug)', to: 'posts#old' # handle old tumblr urls

end
