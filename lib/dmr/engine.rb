module Dmr
  class Engine < ::Rails::Engine
    isolate_namespace Dmr

    Rails.application.
    initializer "dmr.assets.precompile" do |app|
      app.config.assets.paths << "app/assets/*"
      app.config.assets.precompile += %w( dmr/* dmr.scss dmr.js )
      app.config.assets.precompile += ['*.js', '*.css', '**/*.js', '**/*.css', '*.jpg', '*.png', '*.ico', '*.gif', '*.woff2', '*.eot', '*.woff', '*.ttf', '*.svg'] 
    end

  end
end