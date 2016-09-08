ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span h1 "Hello!"
        small "Welcome to the Pastor Scoop Database. Any issues? Contact it@arisechurch.govt.nz"
      end
    end
  end
end
