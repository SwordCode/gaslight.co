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

  controller do
    def permitted_params
      params.permit!
    end
  end
end
