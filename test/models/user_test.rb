require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@uke.gov.pl", password: "1qazXSW@", password_confirmation: "1qazXSW@")
  end

  test "User should be valid" do
    assert @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end
 
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "1zX@" 
    assert_not @user.valid?
  end


end
