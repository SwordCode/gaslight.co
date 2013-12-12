TrainingApp::Engine.routes.draw do
  resources :classroom, only: [:index]

  resources :courses, only: [:index, :show] do
    get :theme, on: :member
    resources :registrations do
      get :stats, on: :collection
    end
  end

  namespace :api, defaults: {format: :json} do
    resources :courses
    resources :registrations
  end

  root to: 'courses#index'
end
