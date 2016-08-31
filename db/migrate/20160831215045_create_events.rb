class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :registrations_database_event_id

      t.timestamps null: false
    end

    create_join_table :people, :events
  end
end
