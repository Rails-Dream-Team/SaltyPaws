ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recently Updated Colonies" do
          ul do
            recent = Colony.order(:created_at)
            recent.first(5) do |colony|
              li link_to(colony.name, colony_path(colony))
            end
          end
        end
      end

      column do
        panel "Newest Users" do
          ul do
            User.last(5).map do |user|
              li link_to(user.display_name, user_path(user))
            end
          end
        end
      end
    end
  end # content
end
