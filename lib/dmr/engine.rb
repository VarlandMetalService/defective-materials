module Dmr
  class Engine < ::Rails::Engine
    isolate_namespace Dmr

    initializer :assets do |config|
      Rails.application.config.assets.paths << root.join("app", "assets", "images", "dmr")
    end

    initializer "dmr.assets.precompile" do |app|
      app.config.assets.precompile += %w( dmr/* )
    end
  end
end
