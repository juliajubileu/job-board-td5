require 'rails_helper'

feature 'Recruiter checks incoming applications' do
  scenario 'must be signed in' do
    # Act
    visit root_path
    click_on 'Acesso recrutadores'

    # Assert
    expect(current_path).to eq(new_recruiter_session_path)
  end

  scenario 'successfully' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)
    job = create(:job, company: company, status: :enabled)
    candidate = create(:candidate)
    JobApplication.create!(job: job, candidate: candidate, status: :pending)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on recruiter.email
    click_on job.title
    click_on 'Avaliar candidaturas'

    # Assert
    expect(current_path).to eq(job_job_applications_path(job))
    expect(page).to have_content('Maria Oliveira')
    expect(page).to have_content('Candidaturas pendentes: 1')
    expect(page).to have_link('Enviar proposta')
    expect(page).to have_link('Declinar candidatura')
  end

  scenario 'and can not see applications to other companies' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)
    other_company = create(:company, name: 'Treina Dev',
                                     address: 'Alameda Santos, 1293',
                                     cnpj: '11.555.333/0000-44',
                                     website: 'www.treinadev.com.br',
                                     domain: 'treinadev.com.br')
    job = create(:job, company: other_company, status: :enabled)
    candidate = create(:candidate)
    JobApplication.create!(job: job, candidate: candidate, status: :pending)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on 'Vagas'
    click_on job.title

    # Assert
    expect(page).not_to have_link('Avaliar candidaturas')
  end
end
