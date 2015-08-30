ActiveAdmin.register Topic do
  permit_params :title, :board_id, :user_id

# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  index do
    column 'Board', sortable: :board_id do |topic|
      link_to topic.board.title, [:admin, topic.board]
    end
    column :title
    column 'Creator', sortable: :user_id do |topic|
      link_to topic.user.display_name, [:admin, topic.user]
    end
    column 'Created', sortable: :created_at do |topic|
      topic.created_at.strftime('%H:%M on %m/%d/%Y')
    end
    column 'Updated', sortable: :updated_at do |topic|
      topic.created_at.strftime('%H:%M on %m/%d/%Y')
    end
    column 'Deleted?', sortable: :deleted_at do |topic|
      topic.deleted_at ? 'Yes' : 'No'
    end
    actions
  end

  show do
    panel 'Posts' do
      table_for topic.posts do
        column :user
        column :content
        column 'updated', :updated_at
      end
    end
  end

  sidebar 'Details', only: :show do
    attributes_table_for topic do
      row :user
      row :title
      row :created_at
      row :updated_at
      row :deleted_at
    end
  end

end
