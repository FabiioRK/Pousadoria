require 'rails_helper'

describe "Visitante faz uma busca avançada" do
  it 'a partir da página inicial' do
    # Arrange

    # Act
    visit root_path

    # Assert
    within("header nav") do
      expect(page).to have_link 'Busca avançada'
    end
  end

  it 'e vê as opções para filtrar' do
    # Arrange

    # Act
    visit root_path
    within("header nav") do
      click_on 'Busca avançada'
    end

    # Assert
    expect(page).to have_content 'Escolha a(s) opções desejada(s)'
    within("body > main > div > div.container.w-50 > form") do
      expect(page).to have_field 'Permite pet'
      expect(page).to have_field 'Possui banheiro'
      expect(page).to have_field 'Possui varanda'
      expect(page).to have_field 'Possui ar-condicionado'
      expect(page).to have_field 'Possui TV'
      expect(page).to have_field 'Possui guarda-roupa'
      expect(page).to have_field 'Acessível para deficientes'
    end
  end

  context 'e encontra uma pousada' do
    it 'pelo campo permite pet' do
      # Arrange
      fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
      joao = User.create!(email: 'joao@gmail.com', password: '123456', account_type: :host)
      ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                             registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                             contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"], user: fabio)
      sol = Inn.create!(corporate_name: 'Pousada do Sol LTDA', brand_name: 'Pousada do Sol',
                        registration_number: '11.111.111/0001-11', phone_number: '63922221111',
                        contact_email: 'pousadasol@gmail.com', payment_methods: ["credit_card", "debit_card"],
                        pet_allowed: true, user: joao)
      Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                      city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
      Address.create!(street: 'Avenida Brasil, 500', district: 'Centro',
                      city: 'Salvador', state: 'Bahia', postal_code: '12345-900', inn_id: sol.id)
      Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200', inn_id: ceu_azul.id)
      Room.create!(name: 'Quarto 2', description: 'alguma outra', dimension: '10', standard_price: '100', inn_id: sol.id)

      # Act
      visit root_path
      within("header nav") do
        click_on 'Busca avançada'
      end
      within("body > main > div > div.container.w-50 > form") do
        check 'Permite pet'
        click_on 'Buscar'
      end

      # Assert
      expect(page).to have_content 'Resultado da busca avançada'
      expect(page).to have_content '1 pousada encontrada.'
      within("body > main > div > div.container.w-50 > ul") do
        expect(page).to have_content sol.brand_name
        expect(page).not_to have_content ceu_azul.brand_name
      end
    end

    it 'pelos campos possui banheiro e possui tv' do
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
      Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200', inn_id: sol.id)
      Room.create!(name: 'Quarto 2', description: 'alguma outra', dimension: '10', standard_price: '100',
                   has_bathroom: true, has_tv: true, inn_id: ceu_azul.id)

      # Act
      visit root_path
      within("header nav") do
        click_on 'Busca avançada'
      end
      within("body > main > div > div.container.w-50 > form") do
        check 'Possui banheiro'
        check 'Possui TV'
        click_on 'Buscar'
      end

      # Assert
      expect(page).to have_content 'Resultado da busca avançada'
      expect(page).to have_content '1 pousada encontrada.'
      within("body > main > div > div.container.w-50 > ul") do
        expect(page).to have_content ceu_azul.brand_name
        expect(page).not_to have_content sol.brand_name
      end
    end
  end

  context 'e encontra pousadas' do
    it 'pelos campos permite pet e acessível para deficientes' do
      # Arrange
      fabio = User.create!(email: 'fabio@gmail.com', password: '123456', account_type: :host)
      joao = User.create!(email: 'joao@gmail.com', password: '123456', account_type: :host)
      sergio = User.create!(email: 'sergio@gmail.com', password: '123456', account_type: :host)
      ceu_azul = Inn.create!(corporate_name: 'Pousada Céu Azul LTDA', brand_name: 'Pousada Céu Azul',
                             registration_number: '99.999.999/0001-99', phone_number: '63988889999',
                             contact_email: 'pousadaceuazul@gmail.com', payment_methods: ["debit_card", "pix"],
                             pet_allowed: true, user: fabio)
      sol = Inn.create!(corporate_name: 'Pousada do Sol LTDA', brand_name: 'Pousada do Sol',
                        registration_number: '11.111.111/0001-11', phone_number: '63922221111',
                        contact_email: 'pousadasol@gmail.com', payment_methods: ["credit_card", "debit_card"], user: joao)
      nascente = Inn.create!(corporate_name: 'Pousada Nascente LTDA', brand_name: 'Pousada Nascente',
                             registration_number: '22.222.222/0001-22', phone_number: '63944441111',
                             contact_email: 'pousadanascente@gmail.com', payment_methods: ["cash", "debit_card"],
                             pet_allowed: true, user: sergio)
      Address.create!(street: 'Avenida das palmeiras, 1000', district: 'Plano Diretor Sul',
                      city: 'Palmas', state: 'Tocantins', postal_code: '77015-400', inn_id: ceu_azul.id)
      Address.create!(street: 'Avenida Brasil, 500', district: 'Centro',
                      city: 'Salvador', state: 'Bahia', postal_code: '12345-900', inn_id: sol.id)
      Address.create!(street: 'Avenida JK, 200', district: 'Plano Diretor Norte',
                      city: 'Palmas', state: 'Tocantins', postal_code: '77020-900', inn_id: nascente.id)
      Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200',
                   is_disabled_accessible: true, inn_id: ceu_azul.id)
      Room.create!(name: 'Quarto 2', description: 'alguma outra', dimension: '10', standard_price: '100', inn_id: sol.id)
      Room.create!(name: 'Quarto 3', description: 'alguma outra desc', dimension: '11', standard_price: '150',
                   is_disabled_accessible: true, inn_id: nascente.id)

      # Act
      visit root_path
      within("header nav") do
        click_on 'Busca avançada'
      end
      within("body > main > div > div.container.w-50 > form") do
        check 'Permite pet'
        check 'Acessível para deficientes'
        click_on 'Buscar'
      end

      # Assert
      expect(page).to have_content 'Resultado da busca avançada'
      expect(page).to have_content '2 pousadas encontradas.'
      within("body > main > div > div.container.w-50 > ul") do
        expect(page).to have_content ceu_azul.brand_name
        expect(page).to have_content nascente.brand_name
        expect(page).not_to have_content sol.brand_name
      end
    end

    it 'pelos campos possui varanda e possui ar-condicionado' do
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
      Room.create!(name: 'Quarto 1', description: 'alguma descrição', dimension: '13', standard_price: '200',
                   has_balcony: true, has_air_conditioner: true, inn_id: ceu_azul.id)
      Room.create!(name: 'Quarto 2', description: 'alguma outra', dimension: '10', standard_price: '100', inn_id: sol.id)
      Room.create!(name: 'Quarto 3', description: 'alguma outra desc', dimension: '11', standard_price: '150',
                   has_balcony: true, has_air_conditioner: true, inn_id: nascente.id)

      # Act
      visit root_path
      within("header nav") do
        click_on 'Busca avançada'
      end
      within("body > main > div > div.container.w-50 > form") do
        check 'Possui varanda'
        check 'Possui ar-condicionado'
        click_on 'Buscar'
      end

      # Assert
      expect(page).to have_content 'Resultado da busca avançada'
      expect(page).to have_content '2 pousadas encontradas.'
      within("body > main > div > div.container.w-50 > ul") do
        expect(page).to have_content ceu_azul.brand_name
        expect(page).to have_content nascente.brand_name
        expect(page).not_to have_content sol.brand_name
      end
    end
  end
end