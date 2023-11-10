class CustomPrice < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, :price, presence: true
  validate :no_overlap, :valid_date

  private
  def no_overlap
    if room.custom_prices.where.not(id: id).any? do |existed_price|
      (start_date..end_date).overlaps?(existed_price.start_date..existed_price.end_date)
    end
      errors.add(:base, "Já existem datas cadastradas neste período.")
    end
  end

  def valid_date
    if start_date && end_date
      if start_date > end_date
        errors.add(:base, "A data de início não pode ser maior que a data final.")
      end
      if start_date < DateTime.now
        errors.add(:base, "A data de início deve ser futura.")
      end
    end
  end
end
