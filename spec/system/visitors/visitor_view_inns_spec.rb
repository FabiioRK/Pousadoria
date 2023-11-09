require 'rails_helper'

describe "Visitante vê pousadas" do
  it 'a partir da página inicial' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Pousadas'
  end
end