class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :role
      t.boolean :conference
      t.string :mobile_tel
      t.text :notes
      t.string :email
      t.boolean :pastorscoop, default: false, null: false

      t.timestamps null: false
    end
  end
end
