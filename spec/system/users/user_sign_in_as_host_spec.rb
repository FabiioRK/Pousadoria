require 'rails_helper'

describe "Usuário se autentica" do
  it 'com sucesso como anfitrião e não possui uma pousada' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'fabio@gmail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    # Assert
    within('nav') do
      expect(page).not_to have_link 'Entrar como Anfitrião'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'fabio@gmail.com'
    end
    expect(page).to have_content 'Você deve cadastrar a sua pousada.'
    expect(user.account_type).to eq 'host'
    expect(current_path).to eq new_inn_path
  end

  it 'e faz logout' do
    # Arrange
    User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)

    # Act
    visit root_path
    click_on 'Entrar como Anfitrião'
    within('form') do
      fill_in 'E-mail', with: 'fabio@gmail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    within('nav') do
      click_on 'Sair'
    end

    # Assert
    expect(page).to have_content 'Sessão finalizada com sucesso.'
    expect(page).to have_link 'Entrar como Anfitrião'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_button 'fabio@gmail.com'
  end
end