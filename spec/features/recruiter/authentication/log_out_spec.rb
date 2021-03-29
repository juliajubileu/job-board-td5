require 'rails_helper'

feature 'Recruiter log out of platform' do
  scenario 'successfully' do
    # Arrange
    company = create(:company, name: 'Treina Dev',
                               address: 'Alameda Santos, 1293',
                               cnpj: '11.222.333/0000-44',
                               website: 'www.treinadev.com.br',
                               domain: 'treinadev.com.br')
    recruiter = create(:recruiter, company: company)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on 'Sair'

    # Assert
    expect(page).to have_link 'Acesso recrutadores'
    expect(page).not_to have_content recruiter.email
    expect(page).not_to have_link 'Sair'
  end
end
