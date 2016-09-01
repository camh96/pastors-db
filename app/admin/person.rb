ActiveAdmin.register Person do
  permit_params :first_name, :last_name, :church_id, :conference, :mobile_tel, :notes, :email

  scope "Pastors Coop", :pastorscoop, default: true
  scope "Church Database", :churchdb

  # Sort Index page by last_name then first_name.
  controller do
    def find_collection(options = {})
      super.reorder('last_name NULLS FIRST', 'first_name NULLS FIRST')
    end
  end

  filter :first_name_or_last_name_cont, as: :string, label: "Name"
end
