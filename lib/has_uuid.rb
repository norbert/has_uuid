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
        # * +auto+ - specifies whether the plugin should auto-generate UUIDs on create
        # * +generator+ - sets the UUID generator. Possible values are <tt>:random</tt> for version 4 (default) and <tt>:timestamp</tt> for version 1.
        # * +column+ - specifies the column in which to store the UUID (default: +uuid+).
        def has_uuid(options = {})
          options.reverse_merge!(:auto => true, :generator => :random, :column => :uuid)
          raise ArgumentError unless GENERATORS.include?(options[:generator])

          class_eval do
            send :include, InstanceMethods # hide include from RDoc
            
            if options[:auto]
              before_validation_on_create :assign_uuid
            end

            write_inheritable_attribute :uuid_generator, options[:generator]
            write_inheritable_attribute :uuid_column, options[:column]
          end
        end
      end

      module InstanceMethods #:nodoc:
          def assign_uuid(options = {})
            
            # default options
            { :force => false }.merge!(options)
            
            return if uuid_valid? unless options[:force]
            
            uuid = UUID.send("#{self.class.read_inheritable_attribute(:uuid_generator)}_create").to_s
            send("#{self.class.read_inheritable_attribute(:uuid_column)}=", uuid)
          end
        
          def assign_uuid!
            assign_uuid(:force => true)
            save!
          end
          
          def uuid_valid?
            begin
              UUID.parse(uuid).kind_of? UUID
            rescue ArgumentError, TypeError
              false
            end
          end
          
          def uuid_invalid?
            !uuid_valid?
          end
      end
    end
  end
end
