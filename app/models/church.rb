# == Schema Information
#
# Table name: churches
#
#  id                      :integer          not null, primary key
#  church_name             :string
#  suburb                  :string
#  postcode                :integer
#  city                    :string
#  address                 :string
#  website                 :string
#  landline_tel            :string
#  active                  :boolean          default(TRUE), not null
#  pastorscoop             :boolean          default(FALSE), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  email                   :string
#  email_alternate         :string
#  church_name_alternative :string
#  denomination            :string
#  landline_tel_alternate  :string
#  facebook                :string
#  region                  :string
#

class Church < ActiveRecord::Base
  has_many :people, dependent: :destroy

  validates :name, presence: true

end
