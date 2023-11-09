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

    render :template => "visitors/inns/show"
  end

end
