class VisitorsController < ApplicationController

  def show
    begin
      @inn = Inn.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @inn = nil
    end

    if @inn.nil? || !@inn.active?
      return redirect_to root_path, alert: 'Pousada não existe ou se encontra inativa.'
    end

    @rooms = @inn.rooms.where(active: true)

    render :template => "visitors/inns/show"
  end

  def show_room
    begin
      @room = Room.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @room = nil
    end

    if @room.nil? || !@room.active?
      return redirect_to root_path, alert: 'Quarto não existe ou se encontra inativo.'
    end

    render :template => "visitors/rooms/show"
  end

  def search_inns
    @query = params["query"]

    if @query.present?
      @inns = Inn.where(active: true).joins(:address)
                 .where("LOWER(inns.brand_name) LIKE ? OR LOWER(addresses.district) LIKE ? OR LOWER(addresses.city) LIKE ?",
                        "%#{@query.downcase}%", "%#{@query.downcase}%", "%#{@query.downcase}%")
                 .order("LOWER(inns.brand_name)")

      render :template => "visitors/inns/search"
    end
  end

  def advanced_search_inns
    unless params.has_key?(:button)
      return render :template => "visitors/inns/advanced_search_inns"
    end

    has_bathroom = params[:has_bathroom].present?
    has_balcony = params[:has_balcony].present?
    has_air_conditioner = params[:has_air_conditioner].present?
    has_tv = params[:has_tv].present?
    has_closet = params[:has_closet].present?
    has_safe = params[:has_safe].present?
    is_disabled_accessible = params[:is_disabled_accessible].present?

    rooms = {}
    rooms[:has_bathroom] = has_bathroom if has_bathroom
    rooms[:has_balcony] = has_balcony if has_balcony
    rooms[:has_air_conditioner] = has_air_conditioner if has_air_conditioner
    rooms[:has_tv] = has_tv if has_tv
    rooms[:has_closet] = has_closet if has_closet
    rooms[:has_safe] = has_safe if has_safe
    rooms[:is_disabled_accessible] = is_disabled_accessible if is_disabled_accessible

    @inns = Inn.where(active: true)
    @inns = @inns.where(pet_allowed: true) if params[:pet_allowed].present?

    unless rooms.empty?
      @inns = @inns.left_joins(:rooms).where(rooms: rooms).distinct.order("LOWER(inns.brand_name)")
    end

    render :template => "visitors/inns/search"
  end

end
