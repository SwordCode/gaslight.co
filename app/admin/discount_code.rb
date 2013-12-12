ActiveAdmin.register TrainingApp::DiscountCode do
  menu parent: 'Training', label: 'Discount Codes'

  controller do
    def permitted_params
      params.permit!
    end
  end
end
