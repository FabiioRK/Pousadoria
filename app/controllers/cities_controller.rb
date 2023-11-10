class CitiesController < ApplicationController
  def index
    @cities = Inn.where(active: true).joins(:address).distinct.pluck('addresses.city')

    render :template => "visitors/cities/index"
  end

  def search
    @city = params[:city]

    if @city.present?
      @inns = Inn.where(active: true).joins(:address).where(addresses: { city: @city }).order('LOWER(inns.brand_name) ASC')

      render :template => "visitors/cities/search"
    end
  end
end
