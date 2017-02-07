Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #match ':controller(/:action(/:id(.:format)))', :via => :all
  root :to => "events#index"
  resources :events do
	resources :messages, :controller => 'messages'
  end
end
