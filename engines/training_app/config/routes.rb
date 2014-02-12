TrainingApp::Engine.routes.draw do
  resources :classroom, only: [:index]

  resources :registrations, only: :show

  resources :courses, only: [:index, :show] do
    get :theme, on: :member
    resources :registrations do
      get :stats, on: :collection
    end
  end

  namespace :api, defaults: {format: :json} do
    resources :courses
    resources :registrations
    resources :discount_codes, only: :show
  end

  root to: 'courses#index'
end
