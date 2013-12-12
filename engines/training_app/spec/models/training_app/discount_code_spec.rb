require 'spec_helper'

module TrainingApp
  describe DiscountCode do
    describe 'validation' do
      it { expect(subject).to have(1).error_on(:course) }
      it { expect(subject).to have(1).error_on(:code) }
      it { expect(subject).to have(1).error_on(:price) }
    end
  end
end
