require 'test_helper'

class DomainsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get domains_login_url
    assert_response :success
  end

end
