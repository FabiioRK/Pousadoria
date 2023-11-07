describe "Anfitrião cria um quarto" do
  it 'a partir da pagina geral da sua pousada' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    inn = Inn.create!(brand_name: 'Pousada Céu Azul', payment_methods: ["debit_card", "pix"], user: user)
    Address.create!(postal_code: '77015-400', inn_id: inn.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Meus quartos'
    click_on 'Cadastrar novo quarto'

    # Assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Dimensão')
    expect(page).to have_field('Acomodação máxima')
    expect(page).to have_field('Preço padrão')
    expect(page).to have_field('Possui banheiro')
    expect(page).to have_field('Possui banheiro')
    expect(page).to have_field('Possui varanda')
    expect(page).to have_field('Possui ar-condicionado')
    expect(page).to have_field('Possui tv')
    expect(page).to have_field('Possui guarda-roupa')
    expect(page).to have_field('Possui cofre')
    expect(page).to have_field('Acessível para deficientes')
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    inn = Inn.create!(brand_name: 'Pousada Céu Azul', payment_methods: ["debit_card", "pix"], user: user)
    Address.create!(postal_code: '77015-400', inn_id: inn.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Meus quartos'
    click_on 'Cadastrar novo quarto'
    fill_in 'Nome', with: 'Quarto 1'
    fill_in 'Descrição', with: 'Quarto espaçoso'
    fill_in 'Dimensão', with: '12'
    fill_in 'Acomodação máxima', with: '4'
    fill_in 'Preço padrão', with: '200'
    check 'Possui banheiro'
    check 'Possui varanda'
    check 'Possui ar-condicionado'
    check 'Possui tv'
    check 'Possui guarda-roupa'
    check 'Possui cofre'
    check 'Acessível para deficientes'
    click_on 'Salvar'

    # Assert
    room = Room.last
    expect(current_path).to eq inn_room_path(room.inn, room)
    expect(page).to have_content 'Quarto cadastrado com sucesso.'
    expect(page).to have_content 'Quarto 1'
    expect(page).to have_content '12m2'
  end

end