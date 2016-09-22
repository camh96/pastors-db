ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1
  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span h1 "Hello!"
        small "Welcome to the Pastors Co-Op Database. Any issues? Contact cam.hovell@arisechurch.com"
      end
    end
  

    columns do
      column do
        panel "20 Most Recent People!" do
          ol do
            Person.all.limit(20).order(id: :desc).map do |person|
              li (link_to person.name, admin_person_path(person.id))
            end
          end
        end
      end

      column do
        panel "20 Most Recent Churches!" do
          ol do
            Church.all.limit(20).order(id: :desc).map do |church|
              li (link_to church.name, admin_church_path(church.id))
            end
          end
        end
      end

    end

    end
  end 
 