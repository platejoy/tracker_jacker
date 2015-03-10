# Generic event to track
class Subscription < ActiveRecord::Base
  include ActsAsTrackableEvent::Trackable
  belongs_to :user

  track_event :created, category: 'Subscription', owner: :user,
    if: proc {|sub| sub.created_at_changed?}

  track_event :paused, category: 'Subscription', owner: :user,
    if: proc {|sub| sub.paused_changed? && sub.paused?}
end
