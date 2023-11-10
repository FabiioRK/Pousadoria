require 'rails_helper'

describe "Visitante busca uma pousada" do
  it 'a partir da página inicial' do
    # Arrange

    # Act
    visit root_path

    # Assert
    within("header nav") do
      expect(page).to have_field 'Buscar pousada'
      expect(page).to have_button 'Buscar'
    end
  end

  context 'e encontra uma pousada' do
    it 'pelo nome fantasia' do
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
      fill_in 'Buscar pousada', with: sol.brand_name
      click_on 'Buscar'

      # Assert
      expect(page).to have_content "Pousadas encontradas com: #{sol.brand_name}"
      expect(page).to have_content '1 pousada encontrada.'
      within("ul") do
        expect(page).to have_content sol.brand_name
      end
    end

    it 'pelo bairro' do
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
        fill_in 'Buscar pousada', with: sol.address.district
        click_on 'Buscar'
      end

      # Assert
      expect(page).to have_content "Pousadas encontradas com: #{sol.address.district}"
      expect(page).to have_content '1 pousada encontrada.'
      within("ul") do
        expect(page).to have_content sol.brand_name
      end
    end

    it 'pela cidade' do
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
      fill_in 'Buscar pousada', with: sol.address.city
      click_on 'Buscar'

      # Assert
      expect(page).to have_content "Pousadas encontradas com: #{sol.address.city}"
      expect(page).to have_content '1 pousada encontrada.'
      within("ul") do
        expect(page).to have_content sol.brand_name
      end
    end
  end

  it 'e encontra múltiplas pousadas' do
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
    fill_in 'Buscar pousada', with: 'Pousada'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Pousadas encontradas com: Pousada"
    expect(page).to have_content '2 pousadas encontradas.'
    within("ul") do
      expect(page).to have_content ceu_azul.brand_name
      expect(page).to have_content sol.brand_name
    end
  end
end