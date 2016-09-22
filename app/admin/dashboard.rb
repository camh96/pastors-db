ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1
  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span h1 "Hello!"
        small "Welcome to the Pastors Co-Op Database. Here you will find a list of things that need doing."
      end
    end
  

    columns do
      column do
        panel "Pastors not yet assinged to a Church", :class => 'warning' do
          ol do
            Person.all.limit(20).order(id: :desc).map do |person|
              li (link_to person.name, admin_person_path(person.id))
            end
          end
        end
      end

      column do
        panel "Churches that don't yet have a Pastor assinged" do
          ol do
            Church.where.not(:id => Person.select(:id)).map do |church|
              li (link_to church.name, admin_church_path(church.id))
            end
          end
        end
      end

      column do
        panel "Pastors that don't have a last name" do
          ol do
            Person.where(last_name: [nil, '']).map do |person|
              li (link_to person.name, admin_person_path(person.id))
            end
          end
        end
      end

       column do
        panel "Churches that don't have a location added" do
          ol do
           Church.where(city: [nil, '']).map do |church|
              li (link_to church.name, admin_church_path(church.id))
            end
          end
        end
      end



    end

    end
  end 
 