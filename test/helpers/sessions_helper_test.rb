require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

    def setup
        @user = users(:david)
        remember(@user)

    end
    
    test "current_user returns right user when session is nil" do
        assert_equal @user,current_user            #verifica que o user é igual ao atual
        assert is_logged_in?                    #verifica que user esta login
    end

    test "current_user returns nil when remember digest is wrong" do
        @user.update_attribute(:remember_digest, User.digest(User.new_token))   
        assert_nil current_user
    end
end