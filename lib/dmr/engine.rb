module Dmr
  class Engine < ::Rails::Engine
    isolate_namespace Dmr

    Rails.application.config.assets.paths << "app/assets/*"
    initializer "dmr.assets.precompile" do |app|
      app.config.assets.precompile += %w( dmr/* dmr.scss dmr.js )
    end
    Rails.application.config.assets.precompile += ['*.js', '*.css', '**/*.js', '**/*.css', '*.jpg', '*.png', '*.ico', '*.gif', '*.woff2', '*.eot', '*.woff', '*.ttf', '*.svg'] 

  end
end