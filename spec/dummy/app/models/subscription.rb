# Generic event to track
class Subscription < ActiveRecord::Base
  include TrackerJacker::Trackable
  belongs_to :user

  track_event :created, category: 'Subscription', owner: :user,
    if: proc {|sub| sub.saved_change_to_created_at?}

  track_event :paused, category: 'Subscription', owner: :user,
    if: proc {|sub| sub.saved_change_to_paused? && sub.paused?}
end
