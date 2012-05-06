require 'spec_helper'

describe Anagram do
 
    it { should respond_to(:word) }

    it { should respond_to(:dictionary) }

    it { should respond_to(:anagrams) }

    it { should respond_to(:time_dict_load) }

    it { should respond_to(:time_dict_load) }

    it { should respond_to(:time_dict_load) }

  	describe 'check a word ad_hoc' do
      def sample_dictionary_file
        # Some tests are based on well-known dictionary.txt file stored in test directory.
        "test/sample-dictionary.txt"
      end

      it "for word 'stop' should find 'posts, spot, stop'" do
        anagram = Anagram.new
        anagram.word = "stop"
        anagram.dict_build(sample_dictionary_file)
        anagram.check

        anagram.anagrams.should eq(["post", "spot","stop"])
      end
    end

    describe 'dictionary file' do
      before(:each) { @anagram = Anagram.new }

      it "valid sample should find 62 anagram classes" do		    
		    @anagram.dict_build("test/sample-dictionary.txt")
        @anagram.dict_take().should eq(62)
      end

      it "invalid should find 0 anagrams class" do
		    @anagram = Anagram.new
		    @anagram.dict_take('.').should eq(0)
	    end
	  end


end
