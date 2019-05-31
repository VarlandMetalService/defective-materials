module Dmr
  class DefectiveMaterialsController < ApplicationController
    require 'net/http'
    include SessionsHelper

    def new
    end

    def get_so_info
      @current_user = current_user
      uri = URI("http://localhost:3001/defective_materials/query_so?so_num=#{params[:so_num]}")
      response = Net::HTTP.get(uri)
      @shop_order = Presenter.hash_to_objects(response).first
      respond_to do |format|
        format.js
      end
    end

    def show
      uri = URI("http://localhost:3001/defective_materials/#{params[:id]}")
      @response = Net::HTTP.get(uri)
      @dmr = Presenter.hash_to_objects(@response)
      respond_to do |format|
        format.html
      end
    end
    
  end
end