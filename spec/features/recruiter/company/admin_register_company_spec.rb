require 'rails_helper'

feature 'Recruiter registers company info' do
  scenario 'from home page' do
    # Act
    visit root_url
    click_on 'Acesso recrutadores'
    click_on 'Registre-se'
    within('form') do
      fill_in 'E-mail', with: 'rh@campuscode.com.br'
      fill_in 'Senha', with: 'tr4b4lh0'
      fill_in 'Confirme a senha', with: 'tr4b4lh0'
      click_on 'Salvar'
    end

    # Assert
    expect(current_path).to eq(edit_company_path(Company.last.id))
  end

  scenario 'successfully' do
    # Act
    visit root_url
    click_on 'Acesso recrutadores'
    click_on 'Registre-se'
    within('form') do
      fill_in 'E-mail', with: 'rh@campuscode.com.br'
      fill_in 'Senha', with: 'tr4b4lh0'
      fill_in 'Confirme a senha', with: 'tr4b4lh0'
      click_on 'Salvar'
    end
    within('form') do
      fill_in 'Nome', with: 'Campus Code'
      fill_in 'Sobre a empresa',
              with: 'Treinamentos intensivos em programação'
      fill_in 'Endereço', with: 'Alameda Santos, 1293'
      fill_in 'CNPJ', with: '11.222.333/0000-44'
      fill_in 'Site', with: 'www.campuscode.com.br'
      attach_file 'Logo', Rails.root.join('spec/support/logo_cc.jpg')
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Painel do recrutador - Campus Code')
    expect(page).to have_link('Publicar vagas')
    expect(page).to have_link('Sair')
  end

  scenario 'and must fill all required fields' do
    # Act
    visit root_url
    click_on 'Acesso recrutadores'
    click_on 'Registre-se'
    within('form') do
      fill_in 'E-mail', with: 'rh@campuscode.com.br'
      fill_in 'Senha', with: 'tr4b4lh0'
      fill_in 'Confirme a senha', with: 'tr4b4lh0'
      click_on 'Salvar'
    end
    within('form') do
      fill_in 'Nome', with: ''
      fill_in 'Sobre a empresa', with: ''
      fill_in 'Endereço', with: ''
      fill_in 'CNPJ', with: ''
      fill_in 'Site', with: ''
      attach_file 'Logo',
                  Rails.root.join('spec/support/logo_cc.jpg')
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível salvar as informações')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Site não pode ficar em branco')
    expect(page).not_to have_content('Painel do recrutador - Campus Code')
  end

  scenario 'and name and CNPJ must be unique' do
    # Arrange
    create(:company, domain: 'campuscode.com')

    # Act
    visit root_url
    click_on 'Acesso recrutadores'
    click_on 'Registre-se'
    within('form') do
      fill_in 'E-mail', with: 'rh@campuscode.com.br'
      fill_in 'Senha', with: 'tr4b4lh0'
      fill_in 'Confirme a senha', with: 'tr4b4lh0'
      click_on 'Salvar'
    end
    within('form') do
      fill_in 'Nome', with: 'Campus Code'
      fill_in 'Sobre a empresa',
              with: 'Treinamentos intensivos em programação'
      fill_in 'Endereço', with: 'Alameda Santos, 1293'
      fill_in 'CNPJ', with: '11.222.333/0000-44'
      fill_in 'Site', with: 'www.campuscode.com.br'
      attach_file 'Logo', Rails.root.join('spec/support/logo_cc.jpg')
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('CNPJ já está em uso')
    expect(page).not_to have_content('Painel do recrutador - Campus Code')
  end

  scenario 'and next recruiters will automatically join the company' do
    # Arrange
    company = create(:company)
    create(:recruiter, email: 'rh@campuscode.com.br', password: '123456',
                       company: company)

    # Act
    visit root_path
    click_on 'Acesso recrutadores'
    click_on 'Registre-se'
    within('form') do
      fill_in 'E-mail', with: 'dev@campuscode.com.br'
      fill_in 'Senha', with: 'tr4b4lh0'
      fill_in 'Confirme a senha', with: 'tr4b4lh0'
      click_on 'Salvar'
    end

    # Assert
    expect(current_path).to eq(recruiters_path)
    expect(page).to have_content('Painel do recrutador - Campus Code')
    expect(page).to have_link('Sair')
    expect(page).not_to have_content('Cadastro de empresa')
  end
end
