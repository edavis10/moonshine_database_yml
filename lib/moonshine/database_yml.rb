module Moonshine
  module DatabaseYml

    # Define options for this plugin in your moonshine.yml
    #
    #   :database:
    #     :production:
    #       :adapter: 'mysql'
    #       :database: 'rails_production'
    #       :host: 'localhost'
    #       :username: 'app'
    #       :password: 'password'
    #       :encoding: 'utf8'
    #
    # Then include the plugin and call the recipe(s) you need:
    #
    #  recipe :database_yml
    def database_yml(options = {})
      file("#{rails_root}/config/database.yml",
           :ensure => :present,
           :content => moonshine_stringify_keys(configuration[:database]).to_yaml,
           :before => exec('rake tasks'))
    end

    # Helper, since Rails' version isn't loading in time
    def moonshine_stringify_keys(h)
      h.inject({}) do |options, (key, value)|
        options[key.to_s] = value
        options
      end
    end

  end
end
