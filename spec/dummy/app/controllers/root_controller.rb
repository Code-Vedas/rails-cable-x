class RootController < ApplicationController
  def index
    render json: { version: CableX::VERSION }
  end
end