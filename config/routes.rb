Rails.application.routes.draw do
  devise_for :users

  authenticated :user do 
    root 'categories#index', as: :authenticated_root
  end

  unauthenticated do 
    root 'public#index', as: :unauthenticated_root
  end
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy, :show] do 
    resources :purchases, only: [:new, :create, :destroy] 
  end
end
