ActiveAdmin.register TrainingApp::Chapter do
  config.sort_order = "sort_order_asc"

  menu label: 'Chapters', parent: 'Training'

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column(:id) { |_| link_to(_.id, url_for([:edit, :admin, :training_app, _])) }
    column :course
    column :title
    column :sort_order
    column(:description) { |_| truncate(_.description, length: 40) }
    column :demo
    column(:duration) do |c|
      mm, ss = c.duration.to_i.divmod(60)
      hh, mm = mm.divmod(60)
      hours = hh.to_s.ljust(2, '0')
      minutes = mm.to_s.ljust(2, '0')
      seconds = ss.to_s.ljust(2, '0')
      [hours, minutes, seconds].join(':')
    end
    default_actions
  end

  form do |f|
    f.inputs "Chapter Details" do
      f.input :title
      f.input :section, collection: Hash[TrainingApp::Section.all.map {|s| ["#{s.course.title} - #{s.title}", s.id] }]
      f.input :description, as: :text
      f.input :video_url
      f.input :code_url
      f.input :poster_url
      f.input :duration, placeholder: "In seconds"
      f.input :sort_order
      f.input :demo
    end
    f.actions
  end
end
