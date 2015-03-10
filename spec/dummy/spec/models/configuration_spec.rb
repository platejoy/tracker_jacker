require 'rails_helper'

RSpec.describe Configuration, type: :model do
  let(:configuration) { Configuration.new(color: 'blue', age: 12, height: 60.3, user: user) }
  let(:user) { User.create }

  describe '.track_attribute' do
    context 'when creating' do
      before do
        configuration.save!
        @ae = ActsAsTrackableEvent::TrackableEvent.find_by(event: "height_changed")
      end

      it "saves a created event for height_changed" do
        expect(@ae).to be_present
      end

      it "stores the metadata" do
        expect(@ae.category).to eq("Configuration")
        expect(@ae.owner).to eq(user)
        expect(@ae.trackable).to eq(configuration)
      end

      it "stores the old and new values as strings" do
        expect(@ae.old_value).to eq(nil)
        expect(@ae.new_value).to eq("60.3")
      end
    end

    context 'when changing an attribute' do
      before do
        configuration.save!
        ActsAsTrackableEvent::TrackableEvent.delete_all
        configuration.update(height: 70.8)
        @ae = ActsAsTrackableEvent::TrackableEvent.find_by(event: "height_changed")
      end

      it "stores the old and new values as strings" do
        expect(@ae.old_value).to eq("60.3")
        expect(@ae.new_value).to eq("70.8")
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
