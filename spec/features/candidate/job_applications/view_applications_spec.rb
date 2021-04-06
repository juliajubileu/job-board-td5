require 'rails_helper'

feature 'Candidate views applications' do
  before do
    allow(Time.zone).to receive(:today).and_return Time.new(2021, 2, 3)
  end

  scenario 'must be signed in' do
    # Act
    visit root_path
    click_on 'Acesso candidatos'

    # Assert
    expect(current_path).to eq(new_candidate_session_path)
  end

  scenario 'successfully' do
    # Arrange
    company = create(:company)
    job = create(:job, company: company)
    candidate = create(:candidate)
    JobApplication.create!(job: job, candidate: candidate, status: :pending)

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on candidate.email

    # Assert
    expect(page).to have_content('Minhas candidaturas: 1')
    expect(page).to have_content('Desenvolvedor(a) Web')
    expect(page).to have_link('Acompanhar candidatura')
  end

  scenario 'and can withdrawl application' do
    # Arrange
    company = create(:company)
    job = create(:job, company: company)
    candidate = create(:candidate)
    JobApplication.create!(job: job, candidate: candidate, status: :pending)

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on candidate.email
    click_on 'Acompanhar candidatura'
    click_on 'Retirar candidatura'

    # Assert
    expect(current_path).to eq(candidates_path)
    expect(page).to have_content('Minhas candidaturas: 0')
  end

  scenario 'and can view offers received' do
    # Arrange
    company = create(:company)
    job = create(:job, company: company)
    candidate = create(:candidate)
    application = JobApplication.create!(job: job, candidate: candidate,
                                         status: :approved)
    create(:offer, job_application: application, status: :pending)

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on candidate.email

    # Assert
    expect(page).to have_content('Ofertas recebidas: 1')
  end

  scenario 'and can view rejections received' do
    # Arrange
    company = create(:company)
    job = create(:job, company: company)
    candidate = create(:candidate)
    JobApplication.create!(job: job, candidate: candidate, status: :rejected)

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on candidate.email

    # Assert
    expect(page).to have_content('Candidaturas rejeitadas: 1')
  end
end
