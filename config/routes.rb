Gaslight::Application.routes.draw do
  get "office_hours/create"
  mount TrainingApp::Engine, at: 'training'

  mount BlogApp::Engine, at: 'blog'
  get 'authors', to: redirect('/blog/authors')
  get 'blog.rss', to: 'blog_app/posts#index', format: "rss"
  get 'post/:id(/:slug)', to: 'blog_app/posts#old' # handle old tumblr urls

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  get '/contact', to: 'contact#new'
  resource :contact, controller: :contact, only: :create

  get '/office-hours', to: "office_hours#new"
  resource :office_hours, controller: :office_hours, path: '/office-hours', only: [:create, :new]

  get 'sitemap.xml' => 'sitemaps#index', as: 'sitemap', defaults: { format: "xml" }

  get 'about', to: 'pages#about'
  root to: 'pages#show', id: 'home'

  get "/work", to: "pages#show", id: "work/index"
  get "/404", to: "errors#not_found"
  get "/500", to: "errors#server_error"
end
