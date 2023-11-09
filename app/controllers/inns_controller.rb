class InnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inn, only: [:show, :edit, :update, :authorize_access]
  before_action :authorize_access

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

    if @inn.save
      return redirect_to @inn, notice: 'Pousada cadastrada com sucesso.'
    end

    flash.now.alert = 'Não foi possível cadastrar a pousada.'
    render :new, status: :unprocessable_entity
  end

  def edit; end

  def update
    if @inn.update(inn_params)
      return redirect_to @inn, notice: 'Pousada atualizada com sucesso.'
    end

    flash.now.notice = 'Não foi possível atualizar a pousada'
    render :edit, status: :unprocessable_entity
  end

  def authorize_access
    unless @inn.nil?
      if current_user != @inn.user
        return redirect_to root_path, alert: 'Você não possui permissão.'
      end
    end

    if current_user.account_type != "host"
      redirect_to root_path, alert: 'Você não é o dono de uma pousada.'
    end
  end

  private
  def set_inn
    begin
      @inn = Inn.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @inn = nil
    end
  end

  def inn_params
    filtered_params = params.require(:inn).permit(
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
    filtered_params[:payment_methods] = filtered_params[:payment_methods].reject(&:empty?)
    filtered_params
  end

end