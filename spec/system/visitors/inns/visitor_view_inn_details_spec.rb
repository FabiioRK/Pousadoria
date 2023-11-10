require 'rails_helper'

describe "Visitante seleciona uma pousada" do
  it 'e vê detalhes' do
    # Arrange
    fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    joao = User.create!(email: 'joao@gmail.com', password: '123456', account_type: :host)
    ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                           registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                           contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"], user: fabio)
    sol = Inn.create!(corporate_name: 'Pousada do Sol LTDA', brand_name: 'Pousada do Sol',
                      registration_number: '11.111.111/0001-11', phone_number: '63922221111',
                      contact_email: 'pousadasol@gmail.com', payment_methods: ["credit_card", "debit_card"], user: joao)
    Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                    city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
    Address.create!(street: 'Avenida Brasil, 500', district: 'Centro',
                    city: 'Salvador', state: 'Bahia', postal_code: '12345-900', inn_id: sol.id)

    # Act
    visit root_path
    click_on sol.address.full_city

    # Assert
    expect(current_path).to eq show_inn_path(sol)
    expect(page).to have_content 'Nome Fantasia: Pousada do Sol'
    expect(page).not_to have_content sol.corporate_name
    expect(page).not_to have_content sol.registration_number
  end

  it 'e volta para a página inicial' do
    # Arrange
    fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    joao = User.create!(email: 'joao@gmail.com', password: '123456', account_type: :host)
    ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                           registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                           contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"], user: fabio)
    sol = Inn.create!(corporate_name: 'Pousada do Sol LTDA', brand_name: 'Pousada do Sol',
                      registration_number: '11.111.111/0001-11', phone_number: '63922221111',
                      contact_email: 'pousadasol@gmail.com', payment_methods: ["credit_card", "debit_card"], user: joao)
    Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                    city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
    Address.create!(street: 'Avenida Brasil, 500', district: 'Centro',
                    city: 'Salvador', state: 'Bahia', postal_code: '12345-900', inn_id: sol.id)

    # Act
    visit root_path
    click_on sol.address.full_city
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq root_path
  end
end