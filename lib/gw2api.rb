require "net/https"
require "json"
require "gw2api/event"
require "gw2api/wvw"
require "gw2api/item"
require "gw2api/recipe"

module GW2API
  BASE_URL = "https://api.guildwars2.com/v1" 

  def request(attr = { action: "Get" })
    uri = URI.parse(attr[:url])

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = attr[:ssl]
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE if attr[:ssl] # need to get a cert -_____-

    net_http = Net::HTTP
    request = net_http.const_get(attr[:action]).new(uri.request_uri)
    attr[:headers].each { |key, value| request[key.to_s] = value } if attr[:headers]

    request.set_form_data(attr[:form_data]) if attr[:form_data]

    http.request(request)
  end
end