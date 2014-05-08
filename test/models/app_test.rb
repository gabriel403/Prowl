require 'test_helper'

class AppTest < ActiveSupport::TestCase

  test "should save App" do
    app = App.new
    app.name = 'app1'
    app.organisation_id = 1
    assert app.save, "Failed to save app"
  end

  test "should not save App without name" do
    app = App.new
    app.organisation_id = '1'
    assert_not app.save
  end

  test "should not save App without organisation_id" do
    app = App.new
    app.name = 'app1'
    assert_not app.save
  end

  test "should not save App with illegal organisation_id" do
    app = App.new
    app.name = 'app1'
    app.organisation_id = '3'
    assert_not app.save
  end
end
