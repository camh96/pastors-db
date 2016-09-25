ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1
  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span h1 "Hello!"
        small "Welcome to the Pastors Co-Op Database. Here you will find a list of things that need doing."
      end
    end
  # binding.pry

    columns do

      column do
        panel Person.without_churches.each.count.to_s + " Pastors aren't assigned to a Church" do
          ol do
           Person.without_churches.each do |person|
              li (link_to person.name, admin_person_path(person.id))
            end
          end
        end
      end

      column do
        panel Church.without_pastors.each.count.to_s + " Churches aren't assigned to a Pastor" do
          ol do
           Church.without_pastors.each do |church|
              li (link_to church.name, admin_church_path(church.id))
            end
          end
        end
      end

      column do
        panel Person.where(last_name: [nil, '']).count.to_s + " Pastors don't have a last name" do
          ol do
            Person.where(last_name: [nil, '']).map do |person|
              li (link_to person.name, admin_person_path(person.id))
            end
          end
        end
      end

       column do
        panel Church.where(city: [nil, '']).count.to_s + " Churches don't have a location added" do
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
 