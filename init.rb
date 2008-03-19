require 'has_uuid'

ActiveRecord::Base.class_eval do
  include ActiveRecord::Acts::HasUuid
end
