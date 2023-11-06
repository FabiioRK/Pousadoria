class InnsController < ApplicationController
  before_action :authenticate_user!

  def show
    @inn = Inn.find(params[:id])
  end

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

    if @inn.save
      return redirect_to @inn, notice: 'Pousada cadastrada com sucesso.'
    end

    flash[:notice] = 'Não foi possível cadastrar a pousada.'
    render :new
  end

  private
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
      address_attributes: [:id, :street, :district, :city, :state, :postal_code]
    )
  end

end