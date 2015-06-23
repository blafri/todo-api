module Api
  # Public: Base api controller that all other api controllers inherit from
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    private

    # Internal: Checks if the credentials the user provided for login are valid
    #
    # Returns the user object for the credentials supplied or false if the
    #         credentials are not valid
    def authenticated?
      authenticate_or_request_with_http_basic do |username, password|
        user = User.find_by_user_name(username)
        user && user.authenticate(password)
      end
    end

    # Internal: Sends the appropriate http response when an object is not found
    def object_not_found
      render json: {}, status: :not_found
    end

    # Internal: Returns JSON stating the destroy was successful
    def destroy_successful
      render json: {}, status: :no_content
    end

    # Internal: Returns JSON stating that the object was found but there was a
    #           problem destroying it.
    def destroy_error
      render json: {}, status: :internal_server_error
    end
  end
end
