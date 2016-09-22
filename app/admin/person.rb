ActiveAdmin.register Person do
  config.filters = true
  preserve_default_filters!
  filter :churches_city, collection: proc  {Church.where.not(city: [nil, '']).order(:city).collect(&:city).uniq}, as: :select
  filter :role, collection: proc  {Person.where.not(role: [nil, '']).order(:role).collect(&:role).uniq}, as: :select



  permit_params :first_name, :last_name, :conference, :mobile_tel, :email, :gender, :role, church_ids: []

  scope "Pastors Coop", :pastorscoop, default: true
  scope "Church Database", :churchdb

  # Sort Index page by last_name then first_name.
  controller do
    def find_collection(options = {})
      super.reorder('last_name NULLS FIRST', 'first_name NULLS FIRST')
    end
  end

  index do
    column :first_name, sortable: :name do |person|
      link_to person.first_name, admin_person_path(person)
    end
    column :last_name

    column :churches do |person|
      person.churches.collect do |church|
        link_to church.name, admin_church_path(church)
      end.join(', ').html_safe
    end

    column :city, sortable: :city  do |person|
      person.churches.collect do |church|
        church.city
      end
    end

    column :role
    
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :conference
      row :mobile_tel
      row :email
      row :role
      row :gender
      row :churches do
        person.churches.collect do |church|
          link_to church.name, admin_church_path(church)
        end.join(', ').html_safe
      end
      row :city do
        person.churches.collect do |church|
        church.city
        end
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
      input :role
      input :gender, collection: ["Male", "Female"]

      input :mobile_tel
      input :email

      input :church_ids, as: :select, collection: Church.all, :input_html => {:multiple => true, class: 'select2'}, label: 'Churches'
    end
    f.actions
  end

  # filter :city_cont, as: :string, collection: -> { Church.city }, label: 'City'
end
