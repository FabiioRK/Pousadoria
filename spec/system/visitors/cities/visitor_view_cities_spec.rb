require 'rails_helper'

describe "Visitante vê menu de cidades" do
  it 'através da página inicial' do
    # Arrange
    fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    joao = User.create!(email: 'joao@gmail.com', password: '123456', account_type: :host)
    ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                           registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                           contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"], user: fabio)
    sol = Inn.create!(corporate_name: 'Pousada do Sol LTDA', brand_name: 'Pousada do Sol',
                      registration_number: '11.111.111/0001-11', phone_number: '63922221111',
                      contact_email: 'pousadasol@gmail.com', payment_methods: ["credit_card", "debit_card"], user: joao)
    Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                    city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
    Address.create!(street: 'Avenida Brasil, 500', district: 'Centro',
                    city: 'Salvador', state: 'Bahia', postal_code: '12345-900', inn_id: sol.id)

    # Act
    visit root_path
    within("header nav") do
      click_on 'Cidades'
    end

    # Assert
    expect(page).to have_content 'Lista de cidades'
    within("body > main > div > div.container.w-50 > ul") do
      expect(page).to have_content 'Palmas'
      expect(page).to have_content 'Salvador'
    end
  end

  it 'e vê pousadas com o nome da cidade escolhida' do
    # Arrange
    fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
    joao = User.create!(email: 'joao@gmail.com', password: '123456', account_type: :host)
    sergio = User.create!(email: 'sergio@gmail.com', password: '123456', account_type: :host)
    ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                           registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                           contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"], user: fabio)
    sol = Inn.create!(corporate_name: 'Pousada do Sol LTDA', brand_name: 'Pousada do Sol',
                      registration_number: '11.111.111/0001-11', phone_number: '63922221111',
                      contact_email: 'pousadasol@gmail.com', payment_methods: ["credit_card", "debit_card"], user: joao)
    nascente = Inn.create!(corporate_name: 'Pousada Nascente LTDA', brand_name: 'Pousada Nascente',
                      registration_number: '22.222.222/0001-22', phone_number: '63944441111',
                      contact_email: 'pousadanascente@gmail.com', payment_methods: ["cash", "debit_card"], user: sergio)
    Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                    city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
    Address.create!(street: 'Avenida Brasil, 500', district: 'Centro',
                    city: 'Salvador', state: 'Bahia', postal_code: '12345-900', inn_id: sol.id)
    Address.create!(street: 'Avenida JK, 200', district: 'Plano Diretor Norte',
                    city: 'Palmas', state: 'Tocantins', postal_code: '77020-900', inn_id: nascente.id)

    # Act
    visit root_path
    within("header nav") do
      click_on 'Cidades'
    end
    click_on 'Palmas'

    # Assert
    expect(page).to have_content "Pousadas encontradas na cidade: #{ceu_azul.address.city}"
    within("body > main > div > div.container.w-50 > ul") do
      expect(page).to have_content ceu_azul.brand_name
      expect(page).to have_content nascente.brand_name
      expect(page).not_to have_content sol.brand_name
    end
  end

end