require 'json'
require 'highline/import'

module Sisense
  # Loads config from file and reconciles it with overrides
  module ConfigLoader
    extend self

    def from_file
      return ConfigFile.load
    end

    def from_globals(globals)
      return Config.new(
        hostname: globals[:hostname],
        api_key: globals[:'api-key'],
        username: globals[:username],
        password: globals[:password],
      )
    end

    def from_prompt
      hostname = ask("Sisense URL: ")
      api_key = ask("Sisense API Key: ") { |q| q.validate = /\w+/ }
      username = ask("Sisense Username: ") { |q| q.validate = /\w+/ }
      password = ask("Sisense Password: ") { |q| q.validate = /\w+/ }

      config = Config.new(
        hostname: hostname,
        api_key: api_key,
        username: username,
        password: password,
      )

      return config
    end
  end

  class Config
    attr_reader :hostname, :api_key, :username, :password

    def initialize(attributes = {})
      @hostname = attributes[:hostname]
      @api_key = attributes[:api_key]
      @username = attributes[:username]
      @password = attributes[:password]
    end

    def to_hash
      {
        hostname: @hostname,
        api_key: @api_key,
        username: @username,
        password: @password
      }
    end

    def to_s
      "Config: hostname=#{@hostname} api_key=#{@api_key} username=#{@username} password=#{@password}"
    end

    def pretty
      <<-EOS
        Config:
          hostname: #{@hostname}
          api_key: #{@api_key}
          username: #{@username}
          password: #{@password}
      EOS
    end

    def attributes
      [hostname, api_key, username, password]
    end

    def valid?
      attributes.all? { |attribute| !attribute.nil? }
    end

    def empty?
      attributes.all? { |attribute| attribute.nil? }
    end

    def self.merge(default_config, override_config)
      default_hash = default_config.to_hash
      override_hash = override_config.to_hash.delete_if { |key, value| value.nil? }

      return Config.new(default_hash.merge(override_hash))
    end
  end

  module ConfigSerializer
    extend self

    def serialize(config)
      JSON.generate(config.to_hash)
    end

    def deserialize(string)
      json = JSON.parse(string)

      config_hash = {}
      json.each do |key, value|
        config_hash[key.to_sym] = value
      end

      Config.new(config_hash)
    end
  end

  module ConfigFile
    extend self

    FILENAME = ENV['HOME'] + "/.sisense-cli"

    def persist(config)
      data = ConfigSerializer.serialize(config)

      File.open(FILENAME, "w") do |file|
        file.write(data)
      end
    end

    def load
      file = File.open(FILENAME, "r")
      data = file.read
      file.close

      return ConfigSerializer.deserialize(data)
    rescue Errno::ENOENT
      puts "Error loading config"
      return Config.new
    end

    def exist?
      File.exist?(FILENAME)
    end
  end

end