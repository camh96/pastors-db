module ActiveResource::Caching
  extend  ActiveSupport::Concern

  included do
    class_attribute :cache
    self.cache = nil
  end

  module ClassMethods
    def cache_with(*store_option)
      self.cache = ActiveSupport::Cache.lookup_store(store_option)
      self.alias_method_chain :get, :cache
    end
  end

  def get_with_cache(path, headers = {})
    cached_resource = self.cache.read(path)
    response = if cached_resource && cached_etag = cached_resource["Etag"]
      get_without_cache(path, headers.merge("If-None-Match" => cached_etag))
    else
      get_without_cache(path, headers)
    end
    return cached_resource if response.code == "304"
    self.cache.write(path, response)    
    response
  end
end

ActiveResource::Connection.send :include, ActiveResource::Caching
ActiveResource::Connection.cache_with :file_store, '/tmp/cache'