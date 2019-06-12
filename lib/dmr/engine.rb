module Dmr
  class Engine < ::Rails::Engine
    isolate_namespace Dmr

    initializer :assets do |config|
      Rails
    end

    initializer "dmr.precompile" do |app|
      app.config.assets.paths << root.join("app", "assets", "images", "dmr")
      app.config.assets.precompile += %w( dmr/* )
    end

    initializer "my_engine.precompile" do |app|
      app.config.assets.paths << Rails.root.join('/engines/dmr/app/assets/*')
      app.config.assets.precompile << "dmr/*"
    end


  end
end