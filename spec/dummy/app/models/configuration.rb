class Configuration < ActiveRecord::Base
  include ActsAsTrackableEvent::Trackable
  belongs_to :user
  track_attribute :height, owner: :user, category: 'Configuration'
  track_attributes [:color, :age], owner: :user, category: 'Configuration'
end
