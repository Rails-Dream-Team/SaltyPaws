ActiveAdmin.register Board do
  permit_params :title

  index as: :block do |board|
    div for: board do
      resource_selection_cell board
      h2 link_to board.title, [:admin, board]
      h4 'Newest Topics'
      board.topics.last(5).each do |t|
        div style:"display:block"
          div t.title, style: "display:inline-block"
          div '(created ' + t.updated_at.strftime('%H:%m on %m/%d/%Y)'), style: "display:inline-block"
      end
    end
  end

  show do
    h3 board.title

    panel 'Topics' do
      table_for board.topics do
        column :title
        column 'creator', :user
        column 'updated', :updated_at
      end
    end
  end
  
end
