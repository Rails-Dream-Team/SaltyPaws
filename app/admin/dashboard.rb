ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Colonies" do
          h3 "Recently Updated Colonies"
          ul do
            recent = Colony.order(:updated_at)
            recent.last(5).map do |colony|
              li do
                link_to(colony.name + colony.updated_at.strftime('  (updated %m/%d/%Y)'), colony_path(colony))
              end
            end
          end
          h4 link_to("View All Colonies", colonies_path)
        end
      end

      column do
        panel "Newest Users" do
          ul do
            User.last(5).map do |user|
              li link_to(user.display_name + user.created_at.strftime('  (joined %m/%d/%Y)'), user_path(user))
            end
          end
        end
      end
    end
  end # content
end
