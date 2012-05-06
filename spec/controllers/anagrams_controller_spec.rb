require 'spec_helper'

describe AnagramsController do
  def valid_attributes
  {
    :word => "stop",
    :dictionary=> "test/sample-dictionary.txt"
  }
  end

  def valid_session
  {
    :word => "stop",
    :dictionary=> "test/sample-dictionary.txt"
  }
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created anagram as @anagram" do
        post :create, {:anagram => valid_attributes, :format => '.js'}
        assigns(:anagram).should_not be_nil
      end

      it "render create template" do
        post :create, {:anagram => valid_attributes, :format => '.js' }
        response.should render_template("create")
      end
    end
  end

  describe "GET new" do
    it "assigns a new @anagram" do
      get :new, valid_session
      assigns(:anagram).should_not be_nil
      assigns(:anagram).kind_of?(Anagram).should be_true
    end

    it "render create" do
      get :new, valid_session
      response.should render_template("new")
    end

  end

end
