require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Adam")
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
end
