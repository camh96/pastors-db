require 'active_resource'

ActiveResource::Connection.class_eval do
  alias_method :origin_handle_response, :handle_response
  def handle_response(response)
    Thread.current[:active_resource_connection_response] = response
    origin_handle_response(response)
  end

  def response
    Thread.current[:active_resource_connection_response]
  end
end
