require 'rails_helper'

describe "Anfitrião edita um período de preço" do
  it 'a partir da página dos quartos' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    inn = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                      registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                      contact_email: 'pousada@gmail.com', payment_methods: ["debit_card", "pix"], user: user)
    Address.create!(street: 'Avenida das palmeiras, 1000', postal_code: '77015-400', inn_id: inn.id)
    room = Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200', inn_id: inn.id)
    CustomPrice.create!(start_date: 10.days.from_now, end_date: 15.days.from_now, price: '250', room_id: room.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Meus quartos'
    click_on 'Detalhes'
    within('table') do
      click_on 'Editar'
    end

    # Assert
    expect(page).to have_content 'Editar período de preço'
    expect(page).to have_field('Data de início', with: 10.days.from_now.to_date.to_s)
    expect(page).to have_field('Data final', with: 15.days.from_now.to_date.to_s)
    expect(page).to have_field('Preço', with: '250')
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    inn = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                      registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                      contact_email: 'pousada@gmail.com', payment_methods: ["debit_card", "pix"], user: user)
    Address.create!(street: 'Avenida das palmeiras, 1000', postal_code: '77015-400', inn_id: inn.id)
    room = Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200', inn_id: inn.id)
    CustomPrice.create!(start_date: 10.days.from_now, end_date: 15.days.from_now, price: '250', room_id: room.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Meus quartos'
    click_on 'Detalhes'
    within('table') do
      click_on 'Editar'
    end
    fill_in 'Data de início', with: 15.days.from_now
    fill_in 'Data final', with: 20.days.from_now
    fill_in 'Preço', with: '300'
    click_on 'Salvar'

    # Assert
    expect(current_path).to eq room_path(room)
    expect(page).to have_content 'Período de preços atualizado com sucesso.'
    expect(page).to have_content 15.days.from_now.to_date.strftime("%d/%m/%Y")
    expect(page).to have_content 20.days.from_now.to_date.strftime("%d/%m/%Y")
    expect(page).to have_content 'R$ 300,00'
  end
end