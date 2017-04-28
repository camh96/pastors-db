# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  church_id  :integer
#  conference :boolean
#  mobile_tel :string
#  notes      :text
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ActiveRecord::Base
  has_and_belongs_to_many :churches

  scope :pastorscoop, -> { where(pastorscoop: true) }
  scope :churchdb, -> { where(pastorscoop: false) }

  scope :without_churches, -> { where(id: church_ids_without_pastors) }

  validates :first_name, presence: true

  def name
    [first_name, last_name].join(' ')
  end

  def name_with_church
    first_church = churches.first
    if first_church.present?
      "#{name} (#{first_church.name})"
    else
      name
    end
  end

  def to_s
    name
  end

  def self.church_ids_without_pastors
    Rails.cache.fetch('person_ids_without_churches_' + Person.last_updated_at, expires_in: 10.minutes) do
      Person.all.to_a.keep_if {|p| p.churches.blank?}.collect(&:id)
    end
  end

  private

    def self.last_updated_at
      last_person = Person.order(:updated_at).last

      if last_person.present?
        last_person.updated_at.to_i.to_s
      else
        Time.zone.now.to_i.to_s
      end
    end

end
