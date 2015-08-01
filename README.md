# TrackerJacker

A convenient gem that keeps track of events and changing attributes in your Rails app. Particularly useful for things like auditing and reporting.

## Setup
Run this command to set up the table where TrackableEvents are stored.
```bash
rails generate tracker_jacker:migration
```

It will create this migration for you:

```ruby
class CreateTrackableEvents < ActiveRecord::Migration
  def change
    create_table :trackable_events do |t|
      t.belongs_to :trackable, :polymorphic => true
      t.belongs_to :owner, :polymorphic => true

      t.string :category
      t.string :event
      t.text :new_value
      t.text :old_value

      t.timestamps null: false
    end

    add_index :trackable_events, [:trackable_id, :trackable_type]
    add_index :trackable_events, [:owner_id, :owner_type]
  end
end
```
## Usage

### Tracking Attributes

In an ActiveRecord model, include `TrackerJacker::Trackable` and use it like this:

```ruby
class ShippingInformation < ActiveRecord::Base
  include TrackerJacker::Trackable

  track_attributes :delivery_window, :frequency_in_days, :deliver_at,
    owner: :user, category: 'Subscription'
end
```

You provide the list of attributes you want to keep track of. For each attribute change, a new `TrackerJacker::TrackableEvent` is written to the database that looks like this:

```ruby
#<TrackerJacker::TrackableEvent:0x007f7f7c8d9520
 id: 899,
 trackable_id: 1284,
 trackable_type: "Subscription",
 owner_id: 5717,
 owner_type: "User",
 category: "Subscription",
 event: "delivery_window_changed",
 new_value: "9AM - 11AM",
 old_value: nil,
 created_at: Wed, 18 Mar 2015 23:40:02 UTC +00:00,
 updated_at: Wed, 18 Mar 2015 23:40:02 UTC +00:00>
```

### Tracking Events

In an ActiveRecord model, include `TrackerJacker::Trackable` and use it like this:

```ruby
class Subscription < ActiveRecord::Base
  include TrackerJacker::Trackable

  track_event :paused, category: 'Subscription', owner: :user,
    if: proc { |sub| sub.subscription_paused_changed? && sub.subscription_paused? }
end
```

Do this for each event you want to track.

An event can be anything. You define what it means to trigger the event with the `if` clause. In this case, we want to trigger a "paused" event when a user changes their subscription's `subscription_paused` attribute to "paused". (I know, boring, but it's important!)

 Each time this event is triggered, a new `TrackerJacker::TrackableEvent` is written to the database that looks like this:


```ruby
#<TrackerJacker::TrackableEvent:0x007f7f7ea6a9f0
 id: 974,
 trackable_id: 1270,
 trackable_type: "Subscription",
 owner_id: 6539,
 owner_type: "User",
 category: "Subscription",
 event: "paused",
 new_value: nil,
 old_value: nil,
 created_at: Thu, 19 Mar 2015 00:13:43 UTC +00:00,
 updated_at: Thu, 19 Mar 2015 00:13:43 UTC +00:00>
```

### Retrieving TrackableEvents

Add something like this to your user class (or any model that "owns" TrackableEvents).

```ruby
has_many :trackable_events, foreign_key: :owner_id,
  class_name: 'TrackerJacker::TrackableEvent',
  dependent: :delete_all # if you want audits to be deleted when the user is delete from your site.
```



Then in an admin or audit system (or anywhere you see fit), you can simply call `current_user.trackable_events` to display something amazing like this!

![admin screenshot](https://photos-4.dropbox.com/t/2/AAD2fA5rMtb-LdrZAmykytHgWHpvBhCyLz1V1LeEiduTjQ/12/2239574/png/32x32/1/1438401600/0/2/Screenshot%202015-07-31%2019.11.32.png/CNbYiAEgASACIAMgBCAFIAYgBygBKAIoBw/P79oqYp6AyQyCDmNiKOy0n0aHJUDQoXWVscIs5NU8-s?size=1280x960&size_mode=2)


### That's it and that's all

Let us know if you have feedback, issues, or proposals.
