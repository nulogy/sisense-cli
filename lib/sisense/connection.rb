require 'rest-client'
require 'jwt'
require 'json'


module Sisense
  class Connection
    def initialize(config)
      @hostname = config.hostname
      @api_key = config.api_key
      @username = config.username
      @password = config.password
    end

    def get(endpoint, data = {})
      JSON.parse(RestClient.get(build_url(endpoint), build_header))
    end

    def put(endpoint, data = {})
      RestClient.put(build_url(endpoint), data, build_header)
    end

    def post(endpoint, data = {})
      RestClient.post(build_url(endpoint), data, build_header)
    end

    def delete(endpoint, data = {})
      RestClient.delete(build_url(endpoint), data, build_header)
    end

    private

    def build_url(endpoint)
      "#{@hostname}/api#{endpoint}"
    end

    def build_header
      {
        'x-api-key' => build_jwt,
        'accept' => :json,
      }
    end

    def build_jwt
      JWT.encode({
        iat: Time.now.to_i,
        email: @username,
        password: @password
      }, @api_key)
    end
  end
end