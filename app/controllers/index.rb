require 'uri'
require 'net/http'
require 'json'

get "/" do
	erb :"index.html"
end

post "/learn" do
		url = URI("https://api.github.com/users/#{params[:github]}")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(url)
		request["cache-control"] = 'no-cache'
		request["postman-token"] = '7c05e845-d147-d76c-bc3d-97581694a023'

		response = http.request(request)
		puts response.read_body

		patch = JSON.parse(response.read_body)
		puts patch
		@answer = patch["name"]
		erb :"index.html"
end


