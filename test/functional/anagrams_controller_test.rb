require 'test_helper'

class AnagramsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    #post :create
    #assert_template 'new'
  end
  
  def test_create_valid
    #post :create
    #assert_redirected_to root_url
  end
end