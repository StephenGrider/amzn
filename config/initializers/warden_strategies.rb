Warden::Strategies.add(:auth_by_imei) do 
  def valid? 
    imei_token.present?
  end 
  
  def authenticate!
    u = User.authenticate(imei_token)
    u.nil? ? fail!("Could not log in") : success!(u)
  end
  
  def imei_token
    request.env["HTTP_IMEI_TOKEN"]
  end
end 