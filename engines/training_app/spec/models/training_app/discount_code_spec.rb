require 'spec_helper'

module TrainingApp
  describe DiscountCode do
    describe 'validation' do
      it { expect(subject).to have(1).error_on(:course) }
      it { expect(subject).to have(1).error_on(:code) }
      it { expect(subject).to have(1).error_on(:price) }

      context 'when there are no more uses available' do
        before do
          subject.maximum_uses = 1
          allow(subject).to receive(:uses).and_return(1)
        end

        it { expect(subject).to have(1).error_on(:maximum_uses) }
      end

      context 'when the code has expired' do
        before { subject.expires_on = 1.week.ago }
        it { expect(subject).to have(1).error_on(:expires_on) }
      end
    end

    describe '#remaining_uses' do
      it 'is more than 1 when no registrations exist' do
        expect(subject.remaining_uses).to be >= 1
      end
    end

    describe '#expired?' do
      it "is useable prior to the expiration date" do
        subject.expires_on = 1.week.from_now
        expect(subject).to_not be_expired
      end

      it "is expired on or after the expiration date" do
        subject.expires_on = 1.week.ago
        expect(subject).to be_expired
      end
    end
  end
end
