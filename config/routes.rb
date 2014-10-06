Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  scope "(:locale)", locale: /en|es/ do
    get '/:locale' => 'projects#new'
    
    root to: 'projects#new'
    resources :permit_steps

    # This is different than the Rails intended used of get '/projects', which it should
    # bring you to projects#index page, but since we do not plan to have this page
    # and we need the behavior to go back to new when "back" button is pressed on
    # '/projects' page, so this route is being used.
    get '/projects', to: 'projects#new'
    post '/projects', to: 'projects#create'
    
    # This will reset session variables
    get '/reset' => 'application#reset'

    # Send an email
    get '/send_email' => 'permit_steps#send_email'

    # This will serve the generated permit PDF
    get '/generated_permits/:filename' => 'permit_steps#serve'

    # This is the engine light to make sure application dependency are okay
    get '/.well-known/status' => 'status#check'

  end  
end
  