module TrackerJacker
  module Trackable
    EventTrackingCallback = Struct.new(:event, :if_proc, :owner_method, :category)
    AttributeTrackingCallback = Struct.new(:attribute, :owner_method, :category)

    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        after_save :run_track_event_callbacks
        after_save :run_track_attribute_callbacks
      end
    end

    module ClassMethods
      def analytic_event_tracking_callbacks
        @analytic_event_tracking_callbacks ||= {}
      end

      def analytic_attribute_tracking_callbacks
        @analytic_attribute_tracking_callbacks ||= {}
      end

      def track_event(event, options = {})
        if_proc = options.fetch(:if)
        owner_method = options.fetch(:owner)
        category = options.fetch(:category)

        analytic_event_tracking_callbacks[event] = EventTrackingCallback.new(event, if_proc, owner_method, category)
      end

      def track_attribute(attribute, options = {})
        owner_method = options.fetch(:owner)
        category = options.fetch(:category)

        analytic_attribute_tracking_callbacks[attribute] = AttributeTrackingCallback.new(attribute, owner_method, category)
      end

      def track_attributes(attributes, options = {})
        attributes.each {|attr| track_attribute(attr, options)}
      end
    end

    def run_track_attribute_callbacks
      return if @ignore_tracking

      object = self
      object.class.analytic_attribute_tracking_callbacks.values.each do |event_callback|
        dirty_method = event_callback.attribute.to_s + "_changed?"
        if object.public_send(dirty_method)
          owner = object.public_send(event_callback.owner_method)
          TrackerJacker::TrackableEvent.create(
            category: event_callback.category,
            owner: owner,
            trackable: object,
            event: event_callback.attribute.to_s + "_changed",
            old_value: object.public_send(event_callback.attribute.to_s + "_was"),
            new_value: object.public_send(event_callback.attribute)
          )
        end
      end
      true
    end

    def run_track_event_callbacks
      return if @ignore_tracking

      object = self
      object.class.analytic_event_tracking_callbacks.values.each do |event_callback|
        if event_callback.if_proc.call(object)
          owner = object.public_send(event_callback.owner_method)
          TrackerJacker::TrackableEvent.create(
            category: event_callback.category,
            owner: owner,
            trackable: object,
            event: event_callback.event
          )
        end
      end
      true
    end

    def ignore_tracking!
      @ignore_tracking = true
    end
  end
end
