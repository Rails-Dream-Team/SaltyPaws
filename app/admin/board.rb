ActiveAdmin.register Board do
  permit_params :title

  # index do
  #   tabs do
  #     Board.all.each do |board|
  #       tab board.title do
  #         board.topics.each do |topic|
  #           div link_to(topic.title, topic_path(topic))
  #         end
  #       end
  #     end
  #   end
  # end
end
