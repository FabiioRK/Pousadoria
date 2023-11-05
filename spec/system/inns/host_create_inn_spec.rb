require 'rails_helper'

describe "Anfitrião cadastra uma pousada" do
  it 'após realizar o login' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)

    # Act
    login_as(user)
    visit root_path

    # Assert
    expect(current_path).to eq new_inn_path
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Telefone')
    expect(page).to have_field('Email')
    expect(page).to have_field('Rua')
    expect(page).to have_field('Bairro')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Permite pet')
    expect(page).to have_field('Método de pagamento')
    expect(page).to have_field('Horário do check-in')
    expect(page).to have_field('Horário do check-out')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Políticas de uso')
  end

  # it 'com sucesso' do
  #   # Arrange
  #   user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
  #
  #   # Act
  #   visit root_path
  #   login_as(user)
  #
  #
  #   # Assert
  #
  # end
end