require File.dirname(__FILE__) + '/test_helper'

class Widget < ActiveRecord::Base
  has_uuid
end

class Thingy < ActiveRecord::Base
  has_uuid :auto => false
end

class HasUuidTest < Test::Unit::TestCase
  def test_should_assign_uuid
    @widget = Widget.new
    @widget.assign_uuid
    assert @widget.new_record?
    assert @widget.uuid_valid?
  end

  def test_should_force_assign_uuid
    original_uuid = UUIDTools::UUID.random_create.to_s
    @widget = Widget.new(:uuid => original_uuid)
    @widget.assign_uuid(:force => true)
    assert_not_equal original_uuid, @widget.uuid
  end

  def test_should_force_assign_uuid_and_save
    @widget = Widget.new
    @widget.assign_uuid!
    assert !@widget.new_record?
    assert @widget.uuid_valid?
  end

  def test_should_assign_uuid_on_create
    @widget = Widget.new
    assert_nil @widget.uuid
    @widget.save
    @widget.reload
    assert @widget.uuid_valid?
  end

  def test_should_check_uuid_validity
    @widget = Widget.new
    assert !@widget.uuid_valid?
    @widget.uuid = "test"
    assert !@widget.uuid_valid?
    @widget.uuid = UUIDTools::UUID.random_create.to_s
    assert @widget.uuid_valid?
  end

  def test_should_not_overwrite_valid_uuid
    manual_uuid = UUIDTools::UUID.random_create.to_s
    @widget = Widget.new(:uuid => manual_uuid)
    @widget.save
    assert_equal manual_uuid, @widget.uuid
  end

  def test_should_assign_uuid_when_nil
    @widget = Widget.new
    @widget.save
    assert @widget.uuid_valid?
  end

  def test_should_assign_uuid_when_blank
    @widget = Widget.new(:uuid => "")
    @widget.save
    assert @widget.uuid_valid?
  end

  def test_should_assign_uuid_when_invalid
    @widget = Widget.new(:uuid => "test")
    assert !@widget.uuid_valid?
    @widget.save
    assert @widget.uuid_valid?
  end

  def test_should_not_assign_uuid_on_create_for_thingies
    # such a weird name for a class
    @thingy = Thingy.new
    @thingy.save
    @thingy.reload
    assert_nil @thingy.uuid
  end
end
