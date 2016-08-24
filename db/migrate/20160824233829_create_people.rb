class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.references :church, index: true, foreign_key: true
      t.boolean :conference
      t.string :mobile_tel
      t.text :notes
      t.string :email

      t.timestamps null: false
    end
  end
end
