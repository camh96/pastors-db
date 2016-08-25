ActiveAdmin.register Person do
  permit_params :first_name, :last_name, :church_id, :conference, :mobile_tel, :notes ,:email

  filter :first_name_or_last_name_cont, as: :string, label: "Name"
end
