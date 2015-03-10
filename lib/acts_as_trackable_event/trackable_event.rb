class ActsAsTrackableEvent::TrackableEvent < ActiveRecord::Base
  belongs_to :trackable, polymorphic: true
  belongs_to :owner, polymorphic: true
end
