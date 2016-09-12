require 'uri'

ActiveAdmin.register Church do
  permit_params :active, :address, :church_name, :name_alternative, :city, :country, :denomination, :email, :email_alternate, :facebook, :landline_tel, :landline_tel_alternate, :pastorscoop, :postcode, :suburb, :website, person_ids: []

  config.sort_order = "name_asc"

      # binding.pry

  scope "Pastors Coop", :pastorscoop, default: true
  scope "Church Database", :churchdb

  index do
    # id_column
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
      row :name_alternative
      row :denomination

      row :address
      row :suburb
      row :city
      row :postcode
      # row :country
      row :email do
        mail_to church.email
      end

      row :email_alternate do
        mail_to church.email_alternate
      end

      row :facebook do
        link_to church.name, church.facebook
      end
      row :landline_tel
      row :landline_tel_alternate
      row :pastorscoop

      row :website do
        if church.website.present?
          link_to church.website_sans_scheme, church.website_scheme, target: '_BLANK'
        end
      end
      row :active
    end
    active_admin_comments
  end


  sidebar "Linked Pastor Details", only: :show do
    church.people.collect do |person|
      attributes_table do
        row :name do
         link_to person.name, admin_person_path(person)
        end
        row :email do
          mail_to person.email
        end
        row :phone do
          person.mobile_tel
        end
        row :conference do
          if person.conference
            render :text => '<span class="status_tag yes">Yes</span>'.html_safe
           else
           render :text => '<span class="status_tag no">No</span>'.html_safe
         end
          
        end
        
      end
    end
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

      input :person_ids, as: :select, collection: Person.all, :input_html => {:multiple => true, class: 'select2'}, label: 'People'
    end
    f.actions
  end

end
