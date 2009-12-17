require 'uuidtools'

module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    # Use this extension to assign a UUID to your models.
    #
    # Example:
    #
    #    class Post < ActiveRecord::Base
    #      has_uuid
    #    end
    #
    # That is all.
    module HasUuid
      GENERATORS = [:random, :timestamp] #:nodoc:

      # Configuration options are:
      #
      # * <tt>:column</tt> - specifies the column in which to store the UUID (default: +uuid+).
      # * <tt>:auto</tt> - specifies whether the plugin should assign a UUID on create (default: true).
      # * <tt>:generator</tt> - sets the UUID generator. Possible values are <tt>:random</tt> for version 4 (default) and <tt>:timestamp</tt> for version 1.
      def has_uuid(options = {})
        options.reverse_merge!(:auto => true, :generator => :random, :column => :uuid)
        raise ArgumentError, "invalid UUID generator" unless GENERATORS.include?(options[:generator])

        class_eval do
          send :include, InstanceMethods # hide include from RDoc

          if options[:auto]
            # always applies to subclasses
            before_validation_on_create :assign_uuid
          end

          class_inheritable_reader :uuid_column
          write_inheritable_attribute :uuid_column, options[:column]

          class_inheritable_reader :uuid_generator
          write_inheritable_attribute :uuid_generator, options[:generator]
        end
      end

      module InstanceMethods #:nodoc:
        def assign_uuid(options = {})
          return if uuid_valid? unless options[:force]

          uuid = UUIDTools::UUID.send("#{uuid_generator}_create").to_s
          send("#{uuid_column}=", uuid)
        end

        def assign_uuid!
          assign_uuid(:force => true)
          save!
        end

        def uuid_valid?
          uuid = send(uuid_column)
          return false if uuid.blank?
          begin
            UUIDTools::UUID.parse(uuid).kind_of?(UUIDTools::UUID)
          rescue ArgumentError, TypeError
            false
          end
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  extend ActiveRecord::Acts::HasUuid
end
