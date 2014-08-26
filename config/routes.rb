Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: 'permits#new'

  #resources :permits
  resources :permit_steps

  get '/permits', to: 'permits#new'
  post '/permits', to: 'permits#create'
  
  # This will reset session variables
  get '/reset' => 'application#reset'

  # This will serve the generated permit PDF
  get '/generated_permits/:filename' => 'permit_steps#serve'

  # This is the engine light to make sure application dependency are okay
  get '/.well-known/status' => 'status#check'
  
end
  