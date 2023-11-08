class CustomPricesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_custom_price, only: [:edit, :update, :destroy]
  before_action :set_room, only: [:new, :create]

  def new
    @custom_price = CustomPrice.new
  end

  def create
    @custom_price = @room.custom_prices.build(room_price_params)

    if @custom_price.save
      return redirect_to room_path(@room), notice: 'Período de preços adicionado com sucesso.'
    end

    flash.now.alert = 'Não foi possível cadastrar o período de preços'
    render :new
  end

  def edit
    @room = @custom_price.room
  end

  def update
    if @custom_price.update(room_price_params)
      return redirect_to room_path(@custom_price.room), notice: 'Período de preços atualizado com sucesso.'
    end

    flash.now.alert = 'Não foi possível atualizar o período de preços'
    render :edit
  end

  def destroy
    @custom_price.destroy
    redirect_to room_custom_prices_path(@custom_price.room), notice: 'Período de preços removido com sucesso.'
  end

  private
  def room_price_params
    params.require(:custom_price).permit(
      :start_date,
      :end_date,
      :price,
      :room_id
    )
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_custom_price
    @custom_price = CustomPrice.find(params[:id])
  end
end
