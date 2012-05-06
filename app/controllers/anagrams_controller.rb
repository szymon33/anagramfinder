class AnagramsController < ApplicationController
    respond_to :html, :xml
    respond_to :js, :only => [:create]

	def new
	  @anagram = Anagram.new	  
	  	  	  
	  respond_with do |format|
	      format.html { render :layout => ! request.xhr? }
	  end	  
	end
	
	def create
	  params["anagram"]["dict_status"] = session[:dict_status] 
	  @anagram = Anagram.new(params[:anagram])
	  
	  if remotipart_submitted?
	  	@anagram.dict_build(@anagram.dictionary.path)
	  	session[:dict_status] =  @anagram.dict_status
  	  end

	  if @anagram.valid?
		 @anagram.check
		 render :layout => false
	  end  	 
	end      
end
    