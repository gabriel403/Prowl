class CustomFailure < Devise::FailureApp
  def respond
    self.status = :unauthorized
    self.response_body = {:message =>   "Invalid or missing authentication token"}.to_json
    self.content_type = "json"
  end
end
