require File.dirname(__FILE__) + '/test_helper'

class Widget < ActiveRecord::Base
  has_uuid
end

class HasUuidTest < Test::Unit::TestCase
  def test_should_assign_uuid_on_create
    @widget = Widget.new
    assert_nil @widget.uuid
    @widget.save
    assert_nothing_raised { UUID.parse(@widget.uuid) }
  end
end
