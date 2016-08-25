ActiveAdmin.register Church do
  permit_params :active, :address, :church_name, :church_name_alternative, :city, :denomination, :email, :email_alternate, :facebook, :landline_tel, :landline_tel_alternate, :pastorscoop, :postcode, :suburb, :website

  config.sort_order = "name_asc"

  index do
    #id_column
    column :name, sortable: :name do |church|
      link_to church.name, admin_church_path(church)
    end
    #column :church_name_alternative
    column :denomination

    #column :address
    #column :suburb
    column :city
    #column :postcode
    column :country

    column :email
    #column :email_alternate
    #column :facebook
    column :landline_tel
    #column :landline_tel_alternate
    #column :pastorscoop
    column :website
    column :active
    actions
  end

  show do
    attributes_table do
      row :name
      row :church_name_alternative
      row :denomination

      row :address
      row :suburb
      row :city
      row :postcode
      row :country

      row :email
      row :email_alternate
      row :facebook
      row :landline_tel
      row :landline_tel_alternate
      row :pastorscoop
      row :website
      row :active
      row :people do
        church.people.collect do |person|
          link_to person.name, admin_person_path(person)
        end.join(', ').html_safe
      end
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    inputs do
      input :name
      input :name_alternative
      input :denomination

      input :address
      input :suburb
      input :city
      input :postcode
      input :country, priority_countries: ["NZ","AU","US","CA"]

      input :email
      input :email_alternate
      input :facebook
      input :landline_tel
      input :landline_tel_alternate
      input :pastorscoop
      input :active
      input :website
    end
    f.actions
  end

end
