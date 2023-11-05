class InnsController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def new
    @inn = Inn.new
  end

  def create

  end
end