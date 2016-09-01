ActiveAdmin.register Person do
  permit_params :first_name, :last_name, :conference, :mobile_tel, :email, church_ids: []

  scope "Pastors Coop", :pastorscoop, default: true
  scope "Church Database", :churchdb

  # Sort Index page by last_name then first_name.
  controller do
    def find_collection(options = {})
      super.reorder('last_name NULLS FIRST', 'first_name NULLS FIRST')
    end
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :conference
      row :mobile_tel
      row :email
      row :churches do
        person.churches.collect do |church|
          link_to church.name, admin_church_path(church)
        end.join(', ').html_safe
      end
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    inputs do
      input :first_name
      input :last_name
      input :conference

      input :mobile_tel
      input :email

      input :church_ids, as: :select, collection: Church.all, :input_html => {:multiple => true, class: 'select2'}, label: 'Churches'
    end
    f.actions
  end

  filter :first_name_or_last_name_cont, as: :string, label: "Name"
end
