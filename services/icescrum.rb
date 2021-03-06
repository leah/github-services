class Service::IceScrum < Service
  string    :base_url, :username, :project_key, :password

  def receive_push
	raise_config_error "Invalid username" if data['username'].to_s.empty?
	raise_config_error "Invalid password" if data['password'].to_s.empty?
	raise_config_error "Invalid project key" if data['project_key'].to_s.empty?

	username = data['username'].to_s.gsub(/\s+/, "")
	project_key = data['project_key'].to_s.upcase.gsub(/\s+/, "")
	password = data['password'].to_s.gsub(/\s+/, "")

	if data['base_url'].present?
    	    url = "#{data['base_url']}/ws/p/#{project_key}/commit/save"
       else
	    url = "https://www.kagilum.com/a/ws/p/#{project_key}/commit/save"
       end

  	http.ssl[:verify] = false
	http.basic_auth username, password

	http_post url, { :payload => payload.to_json }
  end

end

