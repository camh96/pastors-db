class Church < ActiveRecord::Base
  has_many :people

  def to_s
    church_name
  end
end
