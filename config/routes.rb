Rails.application.routes.draw do
  resources :check_ins, only: %i[new create edit update show]

  root to: 'check_ins#new'

  # Catch-all route for unmatched URLs
  match '*path', to: 'check_ins#new', via: :all
end
