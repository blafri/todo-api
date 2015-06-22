# Public: Sets up the basic authentication headers to send with the request
#
# Examples:
#
#   http_login(username, Password)
#   GET '/path', {}, @env # explicitly pass @env parameter with request
module AuthRequestHelper
  def http_login(user, pass)
    @env ||= {}
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic
                                 .encode_credentials(user,pass)
  end
end

RSpec.configure do |config|
  config.include AuthRequestHelper, :type => :request
end
