require 'rails_helper'

describe "Visitante seleciona um quarto" do
  it 'e vê detalhes' do
    # Arrange
    fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                           registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                           contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"], user: fabio)
    Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                    city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
    Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200',
                         active: false, inn_id: ceu_azul.id)
    room = Room.create!(name: 'Quarto 2', description: 'alguma outra', dimension: '10', standard_price: '100', inn_id: ceu_azul.id)

    # Act
    visit root_path
    click_on 'Pousada Céu Azul'
    click_on 'Detalhes'

    # Assert
    expect(current_path).to eq show_room_path(room)
    expect(page).to have_content 'Detalhes do quarto'
    expect(page).to have_content "Nome: #{room.name}"
  end

  it 'e volta para a página da pousada' do
    # Arrange
    fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                           registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                           contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"], user: fabio)
    Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                    city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
    Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200',
                 active: false, inn_id: ceu_azul.id)
    Room.create!(name: 'Quarto 2', description: 'alguma outra', dimension: '10', standard_price: '100', inn_id: ceu_azul.id)

    # Act
    visit root_path
    click_on 'Pousada Céu Azul'
    click_on 'Detalhes'
    click_on 'Voltar'

    # Assert
    expect(current_path). to eq show_inn_path(ceu_azul)
  end
end