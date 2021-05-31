class PagesController < ApplicationController
  def home
    render json: {
      success: true
    }
  end
end
