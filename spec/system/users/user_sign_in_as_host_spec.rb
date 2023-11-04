require 'rails_helper'

describe "Usuário se autentica" do
  it 'com sucesso como anfitrião' do
    # Arrange
    user = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: 'host')

    # Act
    visit root_path
    click_on 'Entrar como Anfitrião'
    within('form') do
      fill_in 'E-mail', with: 'fabio@gmail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    # Assert
    expect(current_path).to eq root_path
    within('nav') do
      expect(page).not_to have_link 'Entrar como Anfitrião'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'fabio@gmail.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(user.account_type).to eq 'host'
  end
end