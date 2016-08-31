# == Schema Information
#
# Table name: events
#
#  id                         :integer          not null, primary key
#  name                       :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  subdomain                  :string(255)
#  registration_state         :string(255)      default("Closed"), not null
#  registrations_count        :integer          default(0)
#  band_pickup                :boolean          default(FALSE)
#  online_registrations_count :integer          default(0)
#  archived                   :boolean          default(FALSE)
#

class RegistrationsDatabase::Event < ActiveResource::Base
  include RegistrationsDatabaseResource
end
