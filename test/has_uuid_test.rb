require File.dirname(__FILE__) + '/test_helper'

class Widget < ActiveRecord::Base
  has_uuid
end

class HasUuidTest < Test::Unit::TestCase
  
  def test_method_assign_uuid
    @widget = Widget.new
    @widget.assign_uuid
    assert_nothing_raised { UUID.parse(@widget.uuid) }
  end
  
  def test_method_assign_uuid!
    @widget = Widget.new
    @widget.assign_uuid!
    @widget.reload
    assert_nothing_raised { UUID.parse(@widget.uuid) }
  end
  
  def test_method_uuid_valid?
    @widget = Widget.new(:uuid => UUID.random_create.to_s)
    assert @widget.uuid_valid?
    @widget = Widget.new(:uuid => "not a uuid")
    assert @widget.uuid_invalid?
  end
  
  
  def test_should_assign_uuid_on_create
    @widget = Widget.new
    assert_nil @widget.uuid
    @widget.save
    @widget.reload
    assert_nothing_raised { UUID.parse(@widget.uuid) }
  end
  
  def test_should_not_assign_uuid_if_already_set
    test_uuid = UUID.random_create.to_s
    @widget = Widget.new(:uuid => test_uuid)
    @widget.save
    @widget.reload
    assert_equal(test_uuid, @widget.uuid)
  end
  
  # should eventually do this
  # def test_should_assign_uuid_if_invalid
  #   @widget = Widget.new(:uuid => "not a uuid")
  #   @widget.save
  #   @widget.reload
  #   puts @widget.uuid
  #   assert_nothing_raised { UUID.parse(@widget.uuid) }
  # end
  
end
