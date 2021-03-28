require 'rails_helper'

feature 'Candidate log out of platform' do
  scenario 'successfully' do
    # Arrange
    candidate = create(:candidate)

    # Act
    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Sair'

    # Assert
    expect(page).to have_link 'Acesso candidatos'
    expect(page).to have_link 'Acesso recrutadores'
    expect(page).not_to have_content candidate.email
    expect(page).not_to have_link 'Sair'
  end
end
