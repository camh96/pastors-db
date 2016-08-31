require 'active_support/concern'
require 'active_resource/paginated_collection'

# RegistrationsResource
module RegistrationsDatabaseResource
  extend ActiveSupport::Concern

  included do
    headers['Authorization'] = "Token token=\"#{ENV['ARISE_REGISTRATIONS_API_KEY']}\""
    self.site = URI.join(ENV['ARISE_REGISTRATIONS_SITE'], '/api/v2')
    self.collection_parser = PaginatedCollection
  end

  class_methods do
    def first(limit = 1)
      result = all(params: {per_page: limit})

      if limit > 1
        result.first(limit)
      else
        result.first
      end
    end

    def page(page)
      all(params: {page: page})
    end
  end
end
