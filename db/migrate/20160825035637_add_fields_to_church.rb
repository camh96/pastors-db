class AddFieldsToChurch < ActiveRecord::Migration
  def change
    add_column :churches, :email, :string
    add_column :churches, :email_alternate, :string
    add_column :churches, :church_name_alternative, :string
    add_column :churches, :denomination, :string
    add_column :churches, :landline_tel_alternate, :string
    add_column :churches, :facebook, :string
    add_column :churches, :region, :string
    add_column :churches, :country, :string
  end
end
