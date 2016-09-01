class CreateJoinTableChurchesPeople < ActiveRecord::Migration
  def change
    create_join_table :churches, :people do |t|
      t.index [:church_id, :person_id]
      t.index [:person_id, :church_id]
    end
  end
end
