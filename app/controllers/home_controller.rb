class HomeController < ApplicationController
  before_filter :authenticate_user!
  require_dependency "myserver/test"

  def index
    mytest = Myserver::Test.new
    @thingy = mytest.testy
  end
end
