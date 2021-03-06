Gaslight::Application.routes.draw do
  mount TrainingApp::Engine, at: 'training'

  mount BlogApp::Engine, at: 'blog'
  get 'blog.rss', to: 'blog_app/posts#index', format: "rss"
  get 'post/:id(/:slug)', to: 'blog_app/posts#old' # handle old tumblr urls

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  get '/contact', to: 'contact#new'
  resource :contact, controller: :contact, only: :create

  get 'sitemap.xml' => 'sitemaps#index', as: 'sitemap', defaults: { format: "xml" }
  get 'robots.txt' => 'robots#index', as: 'robots', defaults: { format: "txt" }

  get 'about', to: 'pages#about'
  root to: 'pages#show', id: 'home'

  get "/work", to: "pages#show", id: "work/index"
  get "/404", to: "errors#not_found"
  get "/500", to: "errors#server_error"
end
