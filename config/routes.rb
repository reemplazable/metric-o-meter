# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :statistics, only: %i[index]

  namespace 'api' do
    namespace 'v0' do
      resources :measures, only: %i[index create show] do
        collection do
          get :types
        end
      end
      resources :statistics, only: %i[index]
    end
  end

  # Defines the root path route ("/")
  root 'statistics#index'
end
