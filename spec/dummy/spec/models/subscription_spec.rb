require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:user) { User.create(name: "user guy") }
  let(:subscription) { Subscription.new(user: user) }

  describe '.track_event' do
    context 'when creating' do
      before do
        subscription.save!
      end

      it "saves a created event" do
        ae = TrackerJacker::TrackableEvent.last
        expect(ae).to be_present
        expect(ae.event).to eq("created")
        expect(ae.category).to eq("Subscription")
        expect(ae.owner).to eq(user)
        expect(ae.trackable).to eq(subscription)
      end
    end

    context 'when pausing' do
      before do
        subscription.paused = true
        subscription.save!
      end

      it "saves a paused event" do
        ae = TrackerJacker::TrackableEvent.last
        expect(ae).to be_present
        expect(ae.event).to eq("paused")
        expect(ae.category).to eq("Subscription")
        expect(ae.owner).to eq(user)
        expect(ae.trackable).to eq(subscription)
      end
    end
  end
end
