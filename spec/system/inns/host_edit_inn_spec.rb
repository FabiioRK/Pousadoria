describe "Anfitrião edita uma pousada" do
  it 'a partir da página geral da sua pousada' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    inn = Inn.create!(brand_name: 'Pousada Céu Azul', payment_methods: ["debit_card", "pix"], user: user)
    Address.create!(postal_code: '77015-400', inn_id: inn.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Editar'

    # Assert
    expect(page).to have_content 'Editar Pousada'
    expect(page).to have_field('Nome Fantasia', with: 'Pousada Céu Azul')
    expect(page).to have_checked_field('Cartão de Débito')
    expect(page).to have_checked_field('Pix')
    expect(page).not_to have_checked_field('Cartão de Crédito')
    expect(page).to have_field('CEP', with: '77015-400')
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
    click_on 'Editar'
    fill_in 'Razão Social', with: 'Pousada São João LTDA'
    check 'Dinheiro'
    uncheck 'Cartão de Débito'
    fill_in 'CEP', with: '01153-123'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Pousada atualizada com sucesso.'
    expect(page).to have_content 'Pousada São João LTDA'
    expect(page).to have_content('Dinheiro')
    expect(page).not_to have_content('Cartão de Débito')
    expect(page).to have_content('01153-123')
  end
end