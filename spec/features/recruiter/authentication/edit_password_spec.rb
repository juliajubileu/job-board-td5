require 'rails_helper'

feature 'Recruiter edits password' do
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
    visit root_url
    click_on recruiter.email
    click_on 'Atualizar conta'
    fill_in 'Senha', with: '654321'
    fill_in 'Confirmação de senha', with: '654321'
    fill_in 'Senha atual', with: '124567'
    click_on 'Atualizar'

    # Assert
    expect(page).to have_content('Sua conta foi atualizada com sucesso')
    expect(page).to have_content('rh@treinadev.com.br')
    expect(page).to have_link('Sair')
  end

  scenario 'and password must match confirmation' do
    # Arrange
    company = create(:company, name: 'Treina Dev',
                               address: 'Alameda Santos, 1293',
                               cnpj: '11.222.333/0000-44',
                               website: 'www.treinadev.com.br',
                               domain: 'treinadev.com.br')
    recruiter = create(:recruiter, company: company)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email
    click_on 'Atualizar conta'
    fill_in 'Confirmação de senha', with: '234567'
    fill_in 'Senha', with: '123456'
    fill_in 'Senha atual', with: '124567'
    click_on 'Atualizar'

    # Assert
    expect(page).to have_content('Não foi possível salvar recrutador')
    expect(page).to have_content('Confirmação de senha não é igual a Senha')
    expect(page).to have_link('Sair')
  end
end
