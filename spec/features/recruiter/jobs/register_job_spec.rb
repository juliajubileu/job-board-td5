require 'rails_helper'

feature 'Recruiter register a job opening' do
  scenario 'from home page' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email

    # Assert
    expect(current_path).to eq(recruiters_path)
    expect(page).to have_content('Painel do recrutador - Campus Code')
    expect(page).to have_link('Publicar vaga')
  end
  scenario 'successfully' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email
    click_on 'Publicar vaga'
    within('form') do
      fill_in 'Título', with: 'Desenvolvedor(a) Web'
      fill_in 'Descrição', with: 'Buscamos uma pessoa experiente'
      fill_in 'Requisitos obrigatórios', with: 'Ruby on Rails'
      fill_in 'Nível do cargo', with: 'Pleno'
      fill_in 'Oferta de remuneração', with: 2500
      fill_in 'Vagas disponíveis', with: 3
      fill_in 'Data limite para envio de candidaturas', with: '25/05/2021'
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Vaga publicada com sucesso')
    expect(page).to have_content('Desenvolvedor(a) Web')
    expect(page).to have_content('R$ 2.500,00')
    expect(page).to have_content('Pleno')
    expect(page).to have_link('Editar vaga')
    expect(page).to have_link('Desativar vaga')
  end

  scenario 'and must fill all required fields' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email
    click_on 'Publicar vaga'
    within('form') do
      fill_in 'Título', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Requisitos obrigatórios', with: ''
      fill_in 'Nível do cargo', with: ''
      fill_in 'Oferta de remuneração', with: ''
      fill_in 'Vagas disponíveis', with: ''
      fill_in 'Data limite para envio de candidaturas', with: ''
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível criar a vaga')
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Requisitos obrigatórios não pode')
    expect(page).to have_content('Nível não pode ficar em branco')
    expect(page).to have_content('Oferta de remuneração não pode')
    expect(page).to have_content('Vagas disponíveis não pode ficar em branco')
    expect(page).to have_content('Data limite não pode ficar em branco')
    expect(page).not_to have_link('Editar vaga')
    expect(page).not_to have_link('Desativar vaga')
  end

  scenario 'and remuneration must be higher than minimum wage' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email
    click_on 'Publicar vaga'
    within('form') do
      fill_in 'Título', with: 'Desenvolvedor(a) Web'
      fill_in 'Descrição', with: 'Buscamos uma pessoa experiente.'
      fill_in 'Requisitos obrigatórios', with: 'Ruby on Rails'
      fill_in 'Nível do cargo', with: 'Pleno'
      fill_in 'Oferta de remuneração', with: 1000
      fill_in 'Vagas disponíveis', with: 3
      fill_in 'Data limite para envio de candidaturas', with: '25/05/2021'
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível criar a vaga')
    expect(page).to have_content('maior que salário mínimo (R$1.100,00)')
    expect(page).not_to have_link('Editar vaga')
    expect(page).not_to have_link('Desativar vaga')
  end

  scenario 'and closing date must be in the future' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email
    click_on 'Publicar vaga'
    within('form') do
      fill_in 'Título', with: 'Desenvolvedor(a) Web'
      fill_in 'Descrição', with: 'Buscamos uma pessoa experiente.'
      fill_in 'Requisitos obrigatórios', with: 'Ruby on Rails'
      fill_in 'Nível do cargo', with: 'Pleno'
      fill_in 'Oferta de remuneração', with: 2500
      fill_in 'Vagas disponíveis', with: 3
      fill_in 'Data limite para envio de candidaturas', with: '25/05/2020'
      click_on 'Salvar'
    end

    expect(page).to have_content('Não foi possível criar a vaga')
    expect(page).to have_content('Data limite deve ser futura')
    expect(page).not_to have_link('Editar vaga')
    expect(page).not_to have_link('Desativar vaga')
  end

  scenario 'and total openings must be positive integer' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email
    click_on 'Publicar vaga'
    within('form') do
      fill_in 'Título', with: 'Desenvolvedor(a) Web'
      fill_in 'Descrição', with: 'Buscamos uma pessoa experiente.'
      fill_in 'Requisitos obrigatórios', with: 'Ruby on Rails'
      fill_in 'Nível do cargo', with: 'Pleno'
      fill_in 'Oferta de remuneração', with: 2500
      fill_in 'Vagas disponíveis', with: 0.2
      fill_in 'Data limite para envio de candidaturas', with: '25/05/2021'
      click_on 'Salvar'
    end

    expect(page).to have_content('Não foi possível criar a vaga')
    expect(page).to have_content('Vagas disponíveis deve ser número positivo')
    expect(page).not_to have_link('Editar vaga')
    expect(page).not_to have_link('Desativar vaga')
  end
end
