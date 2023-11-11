require 'rails_helper'

describe "Visitante entra em uma pousada" do
  it 'e vê quartos disponíveis' do
    # Arrange
    fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                           registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                           contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"], user: fabio)
    Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                    city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
    room1 = Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200',
                         active: false, inn_id: ceu_azul.id)
    room2 = Room.create!(name: 'Quarto 2', description: 'alguma outra', dimension: '10', standard_price: '100', inn_id: ceu_azul.id)

    # Act
    visit root_path
    click_on ceu_azul.full_description

    # Assert
    expect(page).to have_content 'Quartos disponíveis'
    expect(page).to have_content room2.name
    expect(page).not_to have_content room1.name
  end

  it 'e não vê quartos indisponíveis' do
    # Arrange
    fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                           registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                           contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"], user: fabio)
    Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                    city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
    room1 = Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200',
                         active: false, inn_id: ceu_azul.id)
    room2 = Room.create!(name: 'Quarto 2', description: 'alguma outra', dimension: '10', standard_price: '100',
                         active: false, inn_id: ceu_azul.id)

    # Act
    visit root_path
    click_on ceu_azul.full_description

    # Assert
    expect(page).to have_content 'Quartos disponíveis'
    expect(page).to have_content 'Não há quartos disponíveis para esta pousada.'
    expect(page).not_to have_content room2.name
    expect(page).not_to have_content room1.name
  end
end