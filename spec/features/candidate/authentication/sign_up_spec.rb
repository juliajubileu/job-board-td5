require 'rails_helper'

feature 'Candidate signs up' do
  scenario 'from the home page' do
    # Act
    visit root_url
    click_on 'Acesso candidatos'

    # Assert
    expect(current_path).to eq(new_candidate_session_path)
  end

  scenario 'and from the job page' do
    # Arrange
    company = create(:company)
    job = create(:job, company: company)

    # Act
    visit root_url
    click_on 'Vagas'
    click_on job.title
    click_on 'Candidate-se para esta vaga'

    # Assert
    expect(current_path).to eq(new_candidate_session_path)
  end

  scenario 'successfully' do
    # Act
    visit root_url
    click_on 'Acesso candidatos'
    click_on 'Registre-se'
    within('form') do
      fill_in 'Nome completo', with: 'Maria da Silva'
      fill_in 'Nome social', with: ''
      fill_in 'CPF', with: '1234560984'
      fill_in 'Conte um pouco sobre você', with: 'Candidata'
      fill_in 'E-mail', with: 'maria@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('maria@email.com')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Acesso candidatos')
    expect(page).not_to have_link('Acesso recrutadores')
  end

  scenario 'and password can not be blank' do
    # Act
    visit root_url
    click_on 'Acesso candidatos'
    click_on 'Registre-se'
    within('form') do
      fill_in 'Nome completo', with: 'Maria da Silva'
      fill_in 'Nome social', with: ''
      fill_in 'CPF', with: '1234560984'
      fill_in 'Conte um pouco sobre você', with: 'Candidata'
      fill_in 'E-mail', with: 'maria@email.com'
      fill_in 'Senha', with: ''
      fill_in 'Confirmação de senha', with: ''
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível salvar candidato')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).not_to have_content('maria@email.com')
    expect(page).not_to have_link('Sair')
  end

  scenario 'and password must match confirmation' do
    # Act
    visit root_url
    click_on 'Acesso candidatos'
    click_on 'Registre-se'
    within('form') do
      fill_in 'Nome completo', with: 'Maria da Silva'
      fill_in 'Nome social', with: ''
      fill_in 'CPF', with: '1234560984'
      fill_in 'Conte um pouco sobre você', with: 'Candidata'
      fill_in 'E-mail', with: 'maria@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '654321'
      click_on 'Salvar'
    end

    expect(page).to have_content('Não foi possível salvar candidato')
    expect(page).to have_content('Confirmação de senha não é igual a Senha')
    expect(page).not_to have_content('maria@email.com')
    expect(page).not_to have_link('Sair')
  end

  scenario 'and email must be valid' do
    # Act
    visit root_url
    click_on 'Acesso candidatos'
    click_on 'Registre-se'
    within('form') do
      fill_in 'Nome completo', with: 'Maria da Silva'
      fill_in 'Nome social', with: ''
      fill_in 'CPF', with: '1234560984'
      fill_in 'Conte um pouco sobre você', with: 'Candidata'
      fill_in 'E-mail', with: 'maria'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível salvar candidato')
    expect(page).to have_content('E-mail não é válido')
    expect(page).not_to have_content('maria@email.com')
    expect(page).not_to have_link('Sair')
  end

  scenario 'and email can not be at use' do
    # Arrange
    create(:candidate)

    # Act
    visit root_url
    click_on 'Acesso candidatos'
    click_on 'Registre-se'
    within('form') do
      fill_in 'Nome completo', with: 'Maria da Silva'
      fill_in 'Nome social', with: ''
      fill_in 'CPF', with: '1234560984'
      fill_in 'Conte um pouco sobre você', with: 'Candidata'
      fill_in 'E-mail', with: 'maria@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível salvar candidato')
    expect(page).to have_content('E-mail já está em uso')
    expect(page).not_to have_content('maria@email.com')
    expect(page).not_to have_link('Sair')
  end

  scenario 'and cpf must be unique' do
    # Arrange
    create(:candidate)

    # Act
    visit root_url
    click_on 'Acesso candidatos'
    click_on 'Registre-se'
    within('form') do
      fill_in 'Nome completo', with: 'Maria da Silva'
      fill_in 'Nome social', with: ''
      fill_in 'CPF', with: '12312312312'
      fill_in 'Conte um pouco sobre você', with: 'Candidata'
      fill_in 'E-mail', with: 'maria.oliveira@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de senha', with: '123456'
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível salvar candidato')
    expect(page).to have_content('CPF já está em uso')
    expect(page).not_to have_content('maria.oliveira@email.com')
    expect(page).not_to have_link('Sair')
  end
end
