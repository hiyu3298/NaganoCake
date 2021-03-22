Rails.application.routes.draw do

  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  namespace :admin do
    root 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :update, :edit]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  scope module: 'public' do
    root 'items#top'

    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'delete_all'
      end
    end
    get 'orders/check', to: 'orders#check'
    get 'orders/thanks', to: 'orders#thanks'
    get '/customers', to: 'customers#show', as: 'customers'
    get 'customers/delete_check'
    resources :orders, only: [:new, :index, :show, :create]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
   end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
