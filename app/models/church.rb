# == Schema Information
#
# Table name: churches
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  suburb                 :string
#  postcode               :integer
#  city                   :string
#  address                :string
#  website                :string
#  landline_tel           :string
#  active                 :boolean          default(TRUE), not null
#  pastorscoop            :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string
#  email_alternate        :string
#  name_alternative       :string
#  denomination           :string
#  landline_tel_alternate :string
#  facebook               :string
#  region                 :string
#  country                :string
#  notes                  :text
#

class Church < ActiveRecord::Base
  has_many :people, dependent: :destroy

  validates :name, presence: true

  scope :pastorscoop, -> { where(pastorscoop: true) }
  scope :churchdb, -> { where(pastorscoop: false) }

end
