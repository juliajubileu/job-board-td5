require 'rails_helper'

feature 'Recruiter edits company job openings' do
  scenario 'From home page' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'dev@campuscode.com.br',
                                   company: company)
    job = create(:job, company: company, status: :enabled)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email
    click_on 'Desenvolvedor(a) Web'

    # Assert
    expect(current_path).to eq(job_path(job))
    expect(page).to have_link('Editar vaga')
  end

  scenario 'Successfully' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'dev@campuscode.com.br',
                                   company: company)
    create(:job, company: company, status: :enabled)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email
    click_on 'Desenvolvedor(a) Web'
    click_on 'Editar vaga'
    within('form') do
      fill_in 'Título', with: 'DevOps'
      fill_in 'Descrição', with: 'Engenheiro DevOps'
      fill_in 'Oferta de remuneração', with: 3000
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Vaga editada com sucesso')
    expect(page).to have_content('Engenheiro DevOps')
    expect(page).to have_content('R$ 3.000,00')
    expect(page).to have_link('Voltar')
    expect(page).not_to have_content('Desenvolvedor(a) Web')
  end

  scenario 'and details must be valid' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'dev@campuscode.com.br',
                                   company: company)
    create(:job, company: company, status: :enabled)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on recruiter.email
    click_on 'Desenvolvedor(a) Web'
    click_on 'Editar vaga'
    within('form') do
      fill_in 'Título', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Requisitos obrigatórios', with: ''
      fill_in 'Nível do cargo', with: ''
      fill_in 'Oferta de remuneração', with: 300
      fill_in 'Vagas disponíveis', with: 0
      fill_in 'Data limite para envio de candidaturas', with: '25/05/2020'
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível editar a vaga')
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Nível não pode ficar em branco')
    expect(page).to have_content('maior que salário mínimo (R$1.100,00)')
    expect(page).to have_content('Vagas disponíveis deve ser número positivo')
    expect(page).to have_content('Data limite deve ser futura')
    expect(page).not_to have_content('Desenvolvedor(a) Mobile')
    expect(page).not_to have_content('Vaga editada com sucesso')
  end

  scenario 'And can not edit a job from another company' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'dev@campuscode.com.br',
                                   company: company)
    other_company = create(:company, name: 'TreinaDev',
                                     address: 'Alameda Santos, 1293',
                                     cnpj: '11.555.333/0000-94',
                                     website: 'treinadev.com.br',
                                     domain: 'treinadev.com.br')
    create(:job, title: 'Tech Lead', company: other_company)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_url
    click_on 'Vagas'
    click_on 'Tech Lead'

    # Assert
    expect(page).not_to have_link('Editar vaga')
  end
end
