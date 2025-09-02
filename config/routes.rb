Rails.application.routes.draw do
  devise_for :users
  root to: proc { [200, {}, ['Hola desde Rails API']] }
end

