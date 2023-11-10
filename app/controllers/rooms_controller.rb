class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :authorize_access]
  before_action :check_room, only: [:show, :edit, :update]
  before_action :authorize_access, only: [:edit, :update, :new, :create]

  def index
    @rooms = current_user.inn.rooms
  end

  def show
    @custom_prices = @room.custom_prices
  end

  def new
    @room = Room.new
    @inn = current_user.inn
  end

  def create
    @room = current_user.inn.rooms.build(room_params)

    if @room.save
      return redirect_to room_path(@room), notice: 'Quarto cadastrado com sucesso.'
    end

    flash.now.alert = 'Não foi possível cadastrar o quarto.'
    render :new, status: :unprocessable_entity
  end

  def edit; end

  def update
    if @room.update(room_params)
      return redirect_to room_path(@room), notice: 'Quarto atualizado com sucesso.'
    end

    flash.now.notice = 'Não foi possível atualizar o quarto.'
    render :edit, status: :unprocessable_entity
  end

  def authorize_access
    unless @room.nil?
      if current_user != @room.inn.user
        return redirect_to root_path, alert: 'Você não possui permissão.'
      end
    end

    if current_user.account_type != "host"
      redirect_to root_path, alert: 'Você não é o dono de uma pousada.'
    end
  end

  def check_room
    if @room.nil?
      redirect_to root_path, alert: 'Esse quarto não existe.'
    end
  end

  private

  def set_room
    @inn = current_user.inn
    begin
      @room = Room.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @room = nil
    end
  end

  def room_params
    params.require(:room).permit(
      :name,
      :description,
      :dimension,
      :max_accommodation,
      :standard_price,
      :has_bathroom,
      :has_balcony,
      :has_air_conditioner,
      :has_tv,
      :has_closet,
      :has_safe,
      :is_disabled_accessible,
      :active
    )
  end
end
