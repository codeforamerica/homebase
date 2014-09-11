Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
root to: 'permits#new'
  scope "(:locale)", locale: /en|es/ do
    get '/:locale' => 'permits#new'
    

    resources :permit_steps

    # This is different than the Rails intended used of get '/permits', which it should
    # bring you to permits#index page, but since we do not plan to have this page
    # and we need the behavior to go back to new when "back" button is pressed on
    # '/permits' page, so this route is being used.
    get '/permits', to: 'permits#new'
    post '/permits', to: 'permits#create'
    
    # This will reset session variables
    get '/reset' => 'application#reset'

    # This will serve the generated permit PDF
    get '/generated_permits/:filename' => 'permit_steps#serve'

    # This is the engine light to make sure application dependency are okay
    get '/.well-known/status' => 'status#check'

  end  
end
  