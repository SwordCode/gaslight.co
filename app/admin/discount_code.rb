ActiveAdmin.register TrainingApp::DiscountCode do
  menu parent: 'Training', label: 'Discount Codes'

  index do
    column :id
    column :course
    column :code
    column :maximum_uses
    column(:uses) { |_| link_to(_.uses, polymorphic_path([:admin, :training_app, :registrations], q: { discount_code_id_eq: _.id })) } 
    column :expires_on
    column :expired?
    column :created_at
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :course
      f.input :code
      f.input :price
      f.input :maximum_uses, label: 'Maximum Uses', hint: 'Optional. Only allow a code to be used a certain number of times. 0 equals unlimited.'
      f.input :expires_on, label: 'Expires On', hint: 'Optional. Only allow a code to be used until a certain date.'
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
