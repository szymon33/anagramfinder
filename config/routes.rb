Anagramfinder::Application.routes.draw do
  resources 'anagrams', :only => [:create, :new] 
  
  root :to => 'anagrams#new'
end
