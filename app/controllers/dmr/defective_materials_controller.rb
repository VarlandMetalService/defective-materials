module Dmr
  class DefectiveMaterialsController < ApplicationController
    require 'net/http'
    skip_after_action :verify_authorized
    
    def new
    end

    def get_so_info
      @current_user = current_user
      uri = URI("#{ENV["API_PATH"]}/defective_materials/new?so_num=#{params[:so_num]}")
      puts uri
      response = Net::HTTP.get(uri)
      @shop_order = Presenter.hash_to_objects(response).first
      respond_to do |format|
        format.js
      end
    end

    def show
      uri = URI("#{ENV['API_PATH']}/defective_materials/#{params[:id]}")
      @response = Net::HTTP.get(uri)
      @dmr = Presenter.hash_to_objects(@response)
      respond_to do |format|
        format.html
      end
    end
    
  end
end