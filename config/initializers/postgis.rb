Rails.application.config.after_initialize do
  ActiveRecord::Base.connection_pool.disconnect!

  # ActiveSupport.on_load(:active_record) do
  #   config = Rails.application.config.database_configuration[Rails.env]
  #   config['adapter'] = 'postgis'
  #   ActiveRecord::Base.establish_connection(config)
  # end

  #   initializer "active_record.initialize_database.override" do |app|

  ActiveSupport.on_load(:active_record) do
    if url = ENV['DATABASE_URL']
      ActiveRecord::Base.connection_pool.disconnect!
      parsed_url = URI.parse(url)
      config =  {
        adapter:             'postgis',
        host:                parsed_url.host,
        encoding:            'unicode',
        database:            parsed_url.path.split("/")[-1],
        port:                parsed_url.port,
        username:            parsed_url.user,
        password:            parsed_url.password
      }
      establish_connection(config)
    end
  end
end
#end

