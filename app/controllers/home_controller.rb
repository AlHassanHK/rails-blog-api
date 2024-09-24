class HomeController < ApplicationController
  def index
    render plain: "api is running up"
  end
end
