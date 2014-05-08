class CustomFailure < Devise::FailureApp
  def respond
    self.status = :unauthorized
    self.response_body = { :elements => {:id => "Authentication Failed", :description =>   "Invalid or missing authentication token"} }.to_json
    self.content_type = "json"
  end
end
