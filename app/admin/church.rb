ActiveAdmin.register Church do
  permit_params :active, :address, :church_name, :church_name_alternative, :city, :denomination, :email, :email_alternate, :facebook, :landline_tel, :landline_tel_alternate, :pastorscoop, :postcode, :suburb, :website

  index do
    id_column
    column :church_name
    #column :church_name_alternative
    column :denomination

    column :active
    column :address
    column :suburb
    column :city
    column :postcode
    column :country

    column :email
    #column :email_alternate
    #column :facebook
    column :landline_tel
    #column :landline_tel_alternate
    #column :pastorscoop
    column :website
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      input :church_name
      input :church_name_alternative
      input :denomination

      input :address
      input :suburb
      input :city
      input :postcode
      input :country

      input :email
      input :email_alternate
      input :facebook
      input :landline_tel
      input :landline_tel_alternate
      input :pastorscoop
      input :active
      input :website
    end
  end

end
