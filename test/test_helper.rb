require 'test/unit'

require 'active_record'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

require File.dirname(__FILE__) + '/../lib/has_uuid'

silence_stream(STDOUT) do
  ActiveRecord::Schema.define do
    create_table :widgets do |t|
      t.string :uuid
    end

    create_table :thingies do |t|
      t.string :uuid
    end
  end
end
