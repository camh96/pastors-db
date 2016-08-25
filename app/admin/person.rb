ActiveAdmin.register Person do
  permit_params :first_name, :last_name, :church_id, :conference, :mobile_tel, :notes ,:email
end
