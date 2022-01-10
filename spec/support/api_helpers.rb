module APIHelpers
  def json
    JSON.parse(response.body, symbolize_names: true, object_class: OpenStruct)
  end
end

RSpec.configure do |config|
  config.include APIHelpers
end
