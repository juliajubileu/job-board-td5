require 'rails_helper'

feature 'Recruiter log in the platform' do
  scenario 'successfully' do
    # Arrange
    company = create(:company, name: 'Treina Dev',
                               address: 'Alameda Santos, 1293',
                               cnpj: '11.222.333/0000-44',
                               website: 'www.treinadev.com.br',
                               domain: 'treinadev.com.br')
    recruiter = create(:recruiter, company: company)

    # Act
    visit root_path
    click_on 'Acesso recrutadores'
    within('form') do
      fill_in 'E-mail', with: recruiter.email
      fill_in 'Senha', with: recruiter.password
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content recruiter.email
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Acesso recrutadores'
  end

  scenario 'and must fill all fields' do
    # Arrange
    company = create(:company, name: 'Treina Dev',
                               address: 'Alameda Santos, 1293',
                               cnpj: '11.222.333/0000-44',
                               website: 'www.treinadev.com.br',
                               domain: 'treinadev.com.br')
    recruiter = create(:recruiter, company: company)

    # Act
    visit root_path
    click_on 'Acesso recrutadores'
    within('form') do
      fill_in 'E-mail', with: ''
      fill_in 'Senha', with: ''
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'E-mail ou senha inválida.'
    expect(page).to have_link 'Acesso recrutadores'
    expect(page).not_to have_content recruiter.email
    expect(page).not_to have_content 'Login efetuado com sucesso'
  end

  scenario 'and with the right email and password' do
    # Arrange
    company = create(:company, name: 'Treina Dev',
                               address: 'Alameda Santos, 1293',
                               cnpj: '11.222.333/0000-44',
                               website: 'www.treinadev.com.br',
                               domain: 'treinadev.com.br')
    recruiter = create(:recruiter, company: company)

    # Act
    visit root_path
    click_on 'Acesso recrutadores'
    within('form') do
      fill_in 'E-mail', with: 'dev@treinadev.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'E-mail ou senha inválidos.'
    expect(page).to have_link 'Acesso recrutadores'
    expect(page).not_to have_content recruiter.email
    expect(page).not_to have_content 'Login efetuado com sucesso'
  end
end
