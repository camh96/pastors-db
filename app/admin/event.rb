ActiveAdmin.register Event do
  permit_params :name, :registrations_database_event_id

  form do |f|
    f.semantic_errors
    inputs do
      input :name
      collection_select :registrations_database_event_id, RegistrationsDatabase::Event.all.sort_by(&:created_at).to_a.reverse, :id, :name, :prompt => 'Please select the corresponding Event from the Registrations Database.'
    end
    f.actions
  end
end
