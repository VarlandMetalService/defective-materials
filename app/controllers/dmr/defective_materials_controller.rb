module Dmr
  class DefectiveMaterialsController < ApplicationController
    require 'net/http'

    def new
    end

    def get_so_info
      url = URI.parse("#{ENV["API_PATH"]}/defective_materials/new?so_num=#{params[:so_num]}")
      req = Net::HTTP::Get.new(url)
      req['Cookie'] = "credentials=#{cookies[:credentials]}"
      res = Net::HTTP.start(url.host, url.port) { |http|
        http.request(req)
      }
      response = res.body
      if response == "You must sign in to continue."
        render status: 401, json: 'You must sign in to continue.'
      else
        @shop_order = Presenter.hash_to_objects(response).first
        respond_to do |format|
          format.js
        end
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