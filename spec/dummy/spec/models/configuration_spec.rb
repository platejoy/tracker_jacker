require 'rails_helper'

RSpec.describe Configuration, type: :model do
  let(:configuration) { Configuration.new(color: 'blue', age: 12, height: 60.3, user: user) }
  let(:user) { User.create }

  describe '.track_attribute' do
    context 'when creating' do
      before do
        configuration.save!
      end

      it "saves a created event for height_changed" do
        ae = ActsAsTrackableEvent::TrackableEvent.find_by(event: "height_changed")
        expect(ae).to be_present
        expect(ae.category).to eq("Configuration")
        expect(ae.owner).to eq(user)
        expect(ae.trackable).to eq(configuration)
      end
    end

    context 'when not attribute does not change' do
      before do
        configuration.save!
        ActsAsTrackableEvent::TrackableEvent.delete_all
        configuration.save!
      end

      it "does not create an event for height_changed" do
        ae = ActsAsTrackableEvent::TrackableEvent.find_by(event: "height_changed")
        expect(ae).to be_nil
      end
    end
  end

  describe '.track_attributes' do
    context 'when creating' do
      before do
        configuration.save!
      end

      it "saves a created event for height_changed" do
        aes = ActsAsTrackableEvent::TrackableEvent.where(event: ["color_changed", "age_changed"])
        expect(aes.count).to eq(2)
        aes.each do |ae|
          expect(ae.category).to eq("Configuration")
          expect(ae.owner).to eq(user)
          expect(ae.trackable).to eq(configuration)
        end
      end
    end
  end
end
