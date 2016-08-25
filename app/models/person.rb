class Person < ActiveRecord::Base
  belongs_to :church

  def to_s
    [first_name, last_name].join(' ')
  end
end
