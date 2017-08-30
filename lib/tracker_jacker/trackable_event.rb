module TrackerJacker
  class TrackableEvent < ActiveRecord::Base
    belongs_to :trackable, polymorphic: true
    belongs_to :owner, polymorphic: true

    def week_created
      created_at.at_beginning_of_week
    end

    def month_created
      created_at.at_beginning_of_month
    end
  end
end
