Anagramfinder::Application.routes.draw do
  resources 'anagrams', :only => [:create, :new] do
  	 	collection { post 'upload_action' } 
  end
  
  root :to => 'anagrams#new'
end
