Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :promotions

  resources :departments do
    resources :products do
      member do
        post :assign_promotion
      end
    end
  end
end
