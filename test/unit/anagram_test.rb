require 'test_helper'

class CheckAwordTest < ActiveSupport::TestCase
	def sample_dictionary_file 
		# Some tests are based on well-known dictionary.txt file stored in test directory.
		"test/sample-dictionary.txt"
	end

	def test_check_a_word_ad_hoc
		a = Anagram.new
		a.word = "stop"
		a.dict_build(sample_dictionary_file)
		a.check
		assert_equal ["post", "spot","stop"], a.anagrams
	end
		
	def test_check_them_all
		# ...
  	end
end	


class AnagramTest < ActiveSupport::TestCase
  def test_if_class_exist
  	assert_not_nil Anagram.new, "Anagram Class (the main app class) does not exist"
  end
      
  def test_if_must_have_dictionary_method_exist
   temp = Anagram.new
   assert_respond_to temp, :must_have_dictionary, "Anagram Class, main app class, does not exist"
  end
    
  def test_if_exist_dictionary_build_method
  	temp = Anagram.new
  	assert_respond_to temp, :dict_build,  "Build dictionary method does not exist"
  end
	
  def test_if_exist_dictionary_take_method
    temp = Anagram.new  	
  	assert_respond_to temp, :dict_take, "Take dictionary method does not exist"
  end
  
  def test_if_exist_check_anagram_method
  	temp = Anagram.new
  	assert_respond_to temp, :check, "Check anagrams method does not exist"
  end
  
end


class MustHaveMethodDictionaryTest < ActiveSupport::TestCase
	def test_no_dictinary_available_error
		temp = Anagram.new
		assert_equal ["No dictinary available"], temp.must_have_dictionary
	end
	
	def test_is_empty_or_invalid_dictionary
		temp = Anagram.new
		temp.dict_status = "bla bla"
		File.delete(Site::TEMP_FILENAME) if File::exist?( Site::TEMP_FILENAME )
		assert_equal "NoMEthodError", temp.must_have_dictionary
	end

end


class DictionaryTakeTest < ActiveSupport::TestCase
	def test_take_vaild_dictionary
		temp = Anagram.new
		temp.dict_build("test/sample-dictionary.txt")
		assert_equal 62, temp.dict_take() , "The dictionary should have 62 anagram classes. This test is based on the given file."
	end
	
	def test_take_invalid_dictionary
		temp = Anagram.new
		assert_equal  0, temp.dict_take('.') , "Take dictionary invalid file test fails."
	end
end

