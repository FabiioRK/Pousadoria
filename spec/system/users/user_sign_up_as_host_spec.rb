require 'rails_helper'

describe "Usuário se cadastra" do
  it 'com sucesso como anfitrião' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar como Anfitrião'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'fabio@gmail.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Finalizar cadastro'

    # Assert
    expect(page).to have_content 'Cadastro realizado com sucesso!'
    within('nav') do
      expect(page).not_to have_link 'Entrar como Anfitrião'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'fabio@gmail.com'
    end
    user = User.last
    expect(user.account_type).to eq "host"
  end
end