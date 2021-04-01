require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "empty_user" do
    user = User.new
    assert_not user.save, "Usuário sem campos preenchidos"
  end

  test "uniquiness" do
    user = User.new
    user.name = 'Ivan'
    user.email = 'ivan@email.com'
    assert_not user.save, "Usuário criado com email igual"
  end
end
