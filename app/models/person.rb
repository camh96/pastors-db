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

  validates :first_name, presence: true

  def name
    [first_name, last_name].join(' ')
  end

  def to_s
    name
  end
end
