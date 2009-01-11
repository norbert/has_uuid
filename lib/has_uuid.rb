require 'uuidtools'

module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    module HasUuid #:nodoc:
      GENERATORS = [:random, :timestamp] #:nodoc:

      def self.included(base) #:nodoc:
        base.extend(ClassMethods)
      end

      # Use this extension to automatically assign a UUID when your model is created.
      #
      # Example:
      #
      #    class Post < ActiveRecord::Base
      #      has_uuid
      #    end
      #
      # That is all.
      module ClassMethods
        # Configuration options are:
        #
        # * +generator+ - sets the UUID generator. Possible values are <tt>:random</tt> for version 4 (default) and <tt>:timestamp</tt> for version 1.
        # * +column+ - specifies the column in which to store the UUID (default: +uuid+).
        def has_uuid(options = {})
          options.reverse_merge!(:generator => :random, :column => :uuid)
          raise ArgumentError unless GENERATORS.include?(options[:generator])

          class_eval do
            send :include, InstanceMethods # hide include from RDoc

            before_validation_on_create :assign_uuid

            write_inheritable_attribute :uuid_generator, options[:generator]
            write_inheritable_attribute :uuid_column, options[:column]
          end
        end
      end

      module InstanceMethods #:nodoc:
        private
          def assign_uuid
            uuid = UUID.send("#{self.class.read_inheritable_attribute(:uuid_generator)}_create").to_s
            send("#{self.class.read_inheritable_attribute(:uuid_column)}=", uuid)
          end
      end
    end
  end
end
