SitepointYtVideos::Application.routes.draw do
  resources :videos, only: [:index, :new, :create]
  root to: 'videos#index'
end
