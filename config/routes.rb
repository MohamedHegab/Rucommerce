Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :promotions
  resources :departments do
    resources :products
  end
end
