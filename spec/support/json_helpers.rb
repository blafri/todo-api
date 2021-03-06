# Public: Adds a json method to parse the json response sent by the server
module JsonHelpers
  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include JsonHelpers, type: :request
end