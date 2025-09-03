Rails.application.routes.draw do
 devise_for :users, defaults: { format: :json },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
    }
  root "home#index"
end

