describe "Anfitrião cria um período de preço" do
  it 'a partir da descrição de um quarto' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    inn = Inn.create!(brand_name: 'Pousada Céu Azul', payment_methods: ["debit_card", "pix"], user: user)
    Address.create!(postal_code: '77015-400', inn_id: inn.id)
    Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200', inn_id: inn.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Meus quartos'
    click_on 'Detalhes'
    click_on 'Criar período de preços'

    # Assert
    expect(page).to have_content 'Criar período de preço'
    expect(page).to have_field('Data de início')
    expect(page).to have_field('Data final')
    expect(page).to have_field('Preço')
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    inn = Inn.create!(brand_name: 'Pousada Céu Azul', payment_methods: ["debit_card", "pix"], user: user)
    Address.create!(postal_code: '77015-400', inn_id: inn.id)
    room = Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200', inn_id: inn.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Meus quartos'
    click_on 'Detalhes'
    click_on 'Criar período de preços'
    fill_in 'Data de início', with: 10.days.from_now
    fill_in 'Data final', with: 15.days.from_now
    fill_in 'Preço', with: '250'
    click_on 'Salvar'

    # Assert
    expect(current_path).to eq room_path(room)
    expect(page).to have_content 'Período de preços adicionado com sucesso.'
    expect(page).to have_content 10.days.from_now.to_date.strftime("%d/%m/%Y")
    expect(page).to have_content 15.days.from_now.to_date.strftime("%d/%m/%Y")
    expect(page).to have_content 'R$ 250,00'
  end
end