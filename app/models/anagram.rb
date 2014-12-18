class Anagram 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :dictionary, :word, :dict_status
  attr_reader :time_dict_load, :time_find_new_anagram, :anagrams
  
  validates_presence_of :word
  validate :must_have_dictionary
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end  
  
  def must_have_dictionary  	
  	if @dict_status.blank? 
  		errors.add(:base, "No dictinary available") 
	  else
		  if @hashed_anagram_clases.blank?
			  (errors.add(:base, "'#{@dictionary.original_filename}' is empty or invalid dictionary")) rescue 'NoMEthodError' 
		  else
			  true
		  end
    end
  end

  def dict_build(path)
  	time_start = Time.now
  	
  	@hashed_anagram_clases = Hash.new([])
  	File.open(path, "r") do |file|
  		while line = file.gets
  			word = line.chomp 
  			@hashed_anagram_clases[word.split('').sort!.join('')] += [word]
  		end
    end
    
  	File.open(temp_file_name, "w") do |file| #delete prevous version
  		Marshal.dump(@hashed_anagram_clases, file)
  	end
  	
  	# “rescue NoMEthodError “ because of unit test call with nil ActionDispatch object
  	@dict_status = "Current  dictionary file ('#{@dictionary.original_filename}') loaded in #{(Time.now - time_start)*1000}ms, #{@hashed_anagram_clases.size} sets of anagrams found." rescue 'NoMEthodError'
  end
  
  def dict_take( path=Site::TEMP_FILENAME )
  	@hashed_anagram_clases = nil

  	begin
  		File.open(path, "r") do |file|
  		  @hashed_anagram_clases = Marshal.load(file)
  		end		
  		ret = @hashed_anagram_clases.size
  	rescue
  		ret = 0
  	end
  	ret	
  end
   		
	def check
		# find anagram class
		time_start = Time.now
		
		anagram = @word.chomp.downcase # cleanup input
		sorted_anagram = anagram.split('').sort!.join('')
		@anagrams = @hashed_anagram_clases[sorted_anagram]
				
		@time_find_new_anagram = (Time.now - time_start)*1000.to_i
	end
	
	private
	def temp_file_name
		# Temp file could be also setup in Rails config\initializers\... 
		Rails.root.join('public',"anagrams.tmp.txt")
	end	
  
end
