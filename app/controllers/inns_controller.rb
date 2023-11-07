class InnsController < ApplicationController
  before_action :set_inn, only: [:show]
  before_action :authenticate_user!

  def show; end

  def new
    @inn = Inn.new
    @inn.build_address
  end

  def create
    if current_user.inn.present?
      return redirect_to current_user.inn, notice: 'Você já possui uma pousada cadastrada.'
    end
    @inn = Inn.new(inn_params)
    @inn.user = current_user

    @inn.payment_methods = params[:inn][:payment_methods].reject(&:empty?)

    if @inn.save
      return redirect_to @inn, notice: 'Pousada cadastrada com sucesso.'
    end

    flash.now.alert = 'Não foi possível cadastrar a pousada.'
    render :new
  end

  private
  def set_inn
    @inn = Inn.find(params[:id])
  end

  def inn_params
    params.require(:inn).permit(
      :corporate_name,
      :brand_name,
      :registration_number,
      :phone_number,
      :contact_email,
      :pet_allowed,
      :checkin_time,
      :checkout_time,
      :description,
      :usage_policies,
      :active,
      address_attributes: [:id, :street, :district, :city, :state, :postal_code],
      payment_methods: []
    )
  end

  def authorize_access
    @inn = Inn.find(params[:id])
    unless current_user == @inn.user
      redirect_to root_path, alert: 'Você não tem permissão para editar essa pousada.'
    end
  end

end