Warden::Strategies.add(:auth_by_guid) do 
  def valid? 
    guid_token.present?
  end 
  
  def authenticate!
    u = User.authenticate(guid_token)
    u.nil? ? fail!("Could not log in") : success!(u)
  end
  
  def guid_token
    request.env["HTTP_guid_TOKEN"]
  end
end 