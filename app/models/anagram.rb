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
			if dict_take.blank?
				@dict_status = nil
				errors.add(:base, "is empty or invalid dictionary") 
			end
		end
	end
  end

  def dict_build
	time_start = Time.now
	
	@hashed_anagram_clases = Hash.new([])
	
	File.open(@dictionary.path, "r") do |file|
		while line = file.gets
			word = line.chomp 
			@hashed_anagram_clases[word.split('').sort!.join('')] += [word]
		end
  	end

	File.open(temp_file_name, "w") do |file| #delete prevous version
		Marshal.dump(@hashed_anagram_clases, file)
	end
	
	@dict_status = "Current  dictionary file (#{@dictionary.original_filename}) loaded in #{(Time.now - time_start)*1000}ms"
  end
  
  def dict_take
	@hashed_anagram_clases = nil
	
	File.open(temp_file_name, "r") do |file|
	  @hashed_anagram_clases = Marshal.load(file)
	end		
	
	@hashed_anagram_clases.size
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
