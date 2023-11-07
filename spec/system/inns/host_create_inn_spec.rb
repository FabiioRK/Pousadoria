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
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Telefone')
    expect(page).to have_field('Email')
    expect(page).to have_field('Rua')
    expect(page).to have_field('Bairro')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Permite pet')
    expect(page).to have_content('Métodos de pagamento')
    expect(page).to have_content('Horário do check-in')
    expect(page).to have_content('Horário do check-out')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Políticas de uso')
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)

    # Act
    login_as(user)
    visit root_path

    fill_in 'Nome Fantasia', with: 'Pousada São João'
    fill_in 'Razão Social', with: 'Pousada São João LTDA'
    fill_in 'CNPJ', with: '99.999.999/0001-99'
    fill_in 'Telefone', with: '63984429244'
    fill_in 'Email', with: 'pousada@gmail.com'
    fill_in 'Rua', with: 'Av das palmeiras, 1000'
    fill_in 'Bairro', with: 'Centro'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '01153-000'
    check 'Permite pet'
    check 'Cartão de Crédito'
    check 'Cartão de Débito'
    check 'Pix'
    select '12', from: 'inn[checkin_time(4i)]'
    select '00', from: 'inn[checkin_time(5i)]'
    select '14', from: 'inn[checkin_time(4i)]'
    select '00', from: 'inn[checkin_time(5i)]'
    fill_in 'Descrição', with: 'Alguma Descrição'
    fill_in 'Políticas de uso', with: 'Algumas Políticas de uso'
    click_on 'Salvar'
    visit root_path
    click_on 'Minha pousada'

    # Assert
    inn = Inn.last
    expect(current_path).to eq "/inns/#{inn.id}"
    expect(page).to have_content('Ativa')
    expect(page).to have_content('Cartão de crédito')
  end

  it 'com dados incompletos' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)

    # Act
    login_as(user)
    visit root_path
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    click_on 'Salvar'

    # Assert
    expect(page).to have_content('Cadastrar nova pousada') #Mensagens de erro nao estao aparecendo
  end
end