Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :campeonato do
    namespace :classificacao_geral do
      resources :jogadas, only: [:create]
    end
  end
end
