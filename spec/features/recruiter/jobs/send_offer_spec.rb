require 'rails_helper'

feature 'Recruiter sends offer to candidate' do
  scenario 'successfully' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)
    job = create(:job, company: company, status: :enabled)
    candidate = create(:candidate)
    application = JobApplication.create!(job: job, candidate: candidate,
                                         status: :pending)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on recruiter.email
    click_on job.title
    click_on 'Avaliar candidaturas'
    click_on 'Enviar proposta'
    within('form') do
      fill_in 'Mensagem de aprovação',
              with: 'Você foi aprovada no processo seletivo!'
      fill_in 'Oferta de remuneração', with: 2500
      fill_in 'Data de início', with: '01/04/2021'
      click_on 'Enviar proposta'
    end
    application.reload

    # Assert
    expect(current_path).to eq(job_job_applications_path(job))
    expect(page).to have_content('Candidaturas aprovadas: 1')
    expect(page).to have_content('Candidaturas pendentes: 0')
    expect(application.approved?).to be_truthy
  end

  scenario 'and must fill all fields' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)
    job = create(:job, company: company, status: :enabled)
    candidate = create(:candidate)
    application = JobApplication.create!(job: job, candidate: candidate,
                                         status: :pending)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on recruiter.email
    click_on job.title
    click_on 'Avaliar candidaturas'
    click_on 'Enviar proposta'
    within('form') do
      fill_in 'Mensagem de aprovação', with: ''
      fill_in 'Oferta de remuneração', with: ''
      fill_in 'Data de início', with: ''
      click_on 'Enviar proposta'
    end

    # Assert
    expect(page).to have_content('Não foi possível enviar oferta')
    expect(page).to have_content('Mensagem não pode ficar em branco')
    expect(page).to have_content('Oferta de remuneração não pode ficar')
    expect(page).to have_content('Data de início não pode ficar em branco')
    expect(application.pending?).to be_truthy
  end

  scenario 'and starting date must be in the future' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)
    job = create(:job, company: company, status: :enabled)
    candidate = create(:candidate)
    application = JobApplication.create!(job: job, candidate: candidate,
                                         status: :pending)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on recruiter.email
    click_on job.title
    click_on 'Avaliar candidaturas'
    click_on 'Enviar proposta'
    within('form') do
      fill_in 'Mensagem de aprovação',
              with: 'Você foi aprovada no processo seletivo!'
      fill_in 'Oferta de remuneração', with: 2500
      fill_in 'Data de início', with: '01/04/2001'
      click_on 'Enviar proposta'
    end

    # Assert
    expect(page).to have_content('Não foi possível enviar oferta')
    expect(page).to have_content('Data de início deve ser futura')
    expect(application.pending?).to be_truthy
  end

  scenario 'and salary must be higher than minimum wage' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)
    job = create(:job, company: company, status: :enabled)
    candidate = create(:candidate)
    application = JobApplication.create!(job: job, candidate: candidate,
                                         status: :pending)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on recruiter.email
    click_on job.title
    click_on 'Avaliar candidaturas'
    click_on 'Enviar proposta'
    within('form') do
      fill_in 'Mensagem de aprovação',
              with: 'Você foi aprovada no processo seletivo!'
      fill_in 'Oferta de remuneração', with: 500
      fill_in 'Data de início', with: '01/04/2021'
      click_on 'Enviar proposta'
    end

    # Assert
    expect(page).to have_content('Não foi possível enviar oferta')
    expect(page).to have_content('maior que salário mínimo (R$1.100,00)')
    expect(application.pending?).to be_truthy
  end

  scenario 'hide button if offer sent' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)
    job = create(:job, company: company, status: :enabled)
    candidate = create(:candidate)
    JobApplication.create!(job: job, candidate: candidate, status: :approved)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on recruiter.email
    click_on job.title
    click_on 'Avaliar candidaturas'

    expect(page).to have_content('Candidaturas aprovadas: 1')
    expect(page).not_to have_link('Enviar proposta')
  end
end
