class CreateChurches < ActiveRecord::Migration
  def change
    create_table :churches do |t|
      t.string :church_name
      t.string :suburb
      t.integer :postcode
      t.string :city
      t.string :address
      t.string :website
      t.string :landline_tel
      t.boolean :active, default: true, null: false
      t.boolean :pastorscoop, default: false, null: false

      t.timestamps null: false
    end
  end
end
