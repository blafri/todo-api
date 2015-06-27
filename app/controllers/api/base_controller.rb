module Api
  # Public: Base api controller that all other api controllers inherit from
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :object_not_found

    def current_user
      @current_user if defined?(@current_user)
    end

    private

    # Internal: Informs the user that they are not allowed to perform the action
    #           by returning a 403 forbidden error
    def user_not_authorized
      render json: {}, status: :forbidden
    end

    # Internal: Checks if the credentials the user provided for login are valid
    def authenticated?
      authenticate_or_request_with_http_basic do |username, password|
        user = User.find_by_user_name(username)
        return false unless (user && user.authenticate(password))
        @current_user = user
        true
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
