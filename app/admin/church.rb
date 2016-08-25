ActiveAdmin.register Church do
  permit_params :church_name, :suburb, :postcode, :city, :address, :website, :landline_tel, :active, :pastorscoop
end
