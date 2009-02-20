require 'test/unit'

require File.dirname(__FILE__) + '/../../../../config/environment'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
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
