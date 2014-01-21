ActiveAdmin.register TrainingApp::Registration do
  menu label: 'Registrations', parent: 'Training'

  index do
    column :id
    column :course
    column :name
    column :organization
    column(:amount) { |_| number_to_currency(_.amount) }
    column(:discounted) { |_| _.discount_code.present? ? "Yes (#{_.discount_code.code})" : 'No' }
    column :created_at
    actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

