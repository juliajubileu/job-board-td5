require 'rails_helper'

feature 'Recruiter rejects candidate' do
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
    click_on 'Declinar candidatura'
    within('form') do
      fill_in 'Motivo da reprovação', with: 'Você não foi aprovado para a vaga!'
      click_on 'Enviar'
    end

    # Assert
    expect(current_path).to eq(job_job_applications_path(job))
    expect(page).to have_content('Candidaturas rejeitadas: 1')
    expect(page).to have_content('Candidaturas pendentes: 0')
    application.reload
    expect(application.rejected?).to be_truthy
  end

  scenario 'and must send a motive' do
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
    click_on 'Declinar candidatura'
    within('form') do
      fill_in 'Motivo da reprovação', with: ''
      click_on 'Enviar'
    end

    # Assert
    expect(page).to have_content('Não foi possível rejeitar candidatura')
    expect(page).to have_content('Motivo não pode ficar em branco')
    expect(application.pending?).to be_truthy
  end

  scenario 'hide button if application rejected' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)
    job = create(:job, company: company, status: :enabled)
    candidate = create(:candidate)
    JobApplication.create!(job: job, candidate: candidate, status: :rejected)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on recruiter.email
    click_on job.title
    click_on 'Avaliar candidaturas'

    # Assert
    expect(page).to have_content('Candidaturas rejeitadas: 1')
    expect(page).not_to have_link('Enviar proposta')
  end
end
