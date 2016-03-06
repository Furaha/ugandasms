require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Adam", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do 
    assert @user.valid?
  end

  test "requires a name" do 
    @user.name = nil
    assert_not @user.valid?
  end

  test "should be unique" do
    dupu = @user.dup
    @user.save
    assert_not dupu.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "fooba"
    assert_not @user.valid?
  end
end
