module Dmr
  class Engine < ::Rails::Engine
    isolate_namespace Dmr

    initializer "dmr.assets.precompile" do |app|
      app.config.assets.paths << Rails.root.join("app", "assets", "images", "dmr")
      app.config.assets.paths << Rails.root.join("app", "assets", "javascripts", "dmr", "filepond")
      app.config.assets.precompile += %w( dmr.scss dmr.js cheap_diagonal_fabric.png dust_scratches.png *.png dmr/filepond/* )
    end

  end
end