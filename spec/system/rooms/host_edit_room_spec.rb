require 'rails_helper'

describe "Anfitrião edita um quarto" do
  it 'a partir da página dos quartos' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    inn = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                      registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                      contact_email: 'pousada@gmail.com', payment_methods: ["debit_card", "pix"], user: user)
    Address.create!(street: 'Avenida das palmeiras, 1000', postal_code: '77015-400', inn_id: inn.id)
    Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200', inn_id: inn.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Meus quartos'
    click_on 'Detalhes'
    click_on 'Editar'

    # Assert
    expect(page).to have_field('Nome', with: 'Quarto 1')
    expect(page).to have_field('Descrição', with: 'alguma descrição')
    expect(page).to have_field('Dimensão', with: '13')
    expect(page).to have_field('Preço padrão', with: '200')
    expect(page).to have_checked_field('Quarto ativo')
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    inn = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                      registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                      contact_email: 'pousada@gmail.com', payment_methods: ["debit_card", "pix"], user: user)
    Address.create!(street: 'Avenida das palmeiras, 1000', postal_code: '77015-400', inn_id: inn.id)
    Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200', inn_id: inn.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Meus quartos'
    click_on 'Detalhes'
    click_on 'Editar'
    fill_in 'Nome', with: 'Quarto 2'
    fill_in 'Acomodação máxima', with: '3'
    check 'Possui banheiro'
    check 'Possui tv'
    check 'Acessível para deficientes'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content('Quarto atualizado com sucesso.')
    expect(page).to have_content('Quarto 2')
    expect(page).to have_content('Dimensão: 13m2')
    expect(page).to have_content('alguma descrição')
    expect(page).to have_content('Acomodação máxima: 3')
    expect(page).to have_content('Preço padrão: R$ 200,00')
    expect(page).to have_content('Possui banheiro: Sim')
    expect(page).to have_content('Possui TV: Sim')
    expect(page).to have_content('Acessível para deficientes: Sim')
  end
end