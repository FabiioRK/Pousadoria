class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :authorize_access]
  before_action :authorize_access, only: [:edit, :update]

  def index
    @rooms = Room.all
  end

  def show
    if @room.nil?
      redirect_to inn_rooms_path(current_user.inn.id), alert: 'Esse quarto não existe'
    end
  end

  def new
    @room = Room.new
    @inn = current_user.inn
  end

  def create
    @room = current_user.inn.rooms.build(room_params)

    if @room.save
      return redirect_to inn_room_path(@room.inn, @room), notice: 'Quarto cadastrado com sucesso.'
    end

    flash.now.alert = 'Não foi possível cadastrar o quarto.'
    render :new
  end

  def edit
    @inn = current_user.inn
  end

  def update
    if @room.update(room_params)
      return redirect_to inn_room_path(@room.inn, @room), notice: 'Quarto atualizado com sucesso.'
    end

    flash.now.notice = 'Não foi possível atualizar a pousada'
    render :edit
  end

  def authorize_access
    if @room.nil?
      redirect_to root_path, alert: 'Esse quarto não existe.'
    elsif current_user != @room.inn.user
      redirect_to root_path, alert: 'Você não tem permissão para editar esse quarto.'
    end
  end

  private
  def set_room
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
