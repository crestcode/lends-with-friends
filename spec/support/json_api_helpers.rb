module JsonApiHelpers
  def parse_json(response)
    JSON.parse(response.body)
  end

  RSpec.configure do |config|
    config.include JsonApiHelpers, type: :controller
  end
end