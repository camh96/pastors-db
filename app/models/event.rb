# == Schema Information
#
# Table name: events
#
#  id                       :integer          not null, primary key
#  name                     :string
#  registration_database_id :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Event < ActiveRecord::Base
  #belongs_to :registrations_database_event
  def registrations_database_event
    RegistrationsDatabase::Event.find registrations_database_event_id
  end
end
