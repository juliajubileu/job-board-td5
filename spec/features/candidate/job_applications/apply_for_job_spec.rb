require 'rails_helper'

feature 'Candidate applies for job' do
  scenario 'From home page' do
    # Arrange
    company = create(:company)
    job = create(:job, company: company)
    candidate = create(:candidate)

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on 'Vagas'
    click_on job.title

    # Assert
    expect(page).to have_link('Candidate-se para esta vaga')
  end

  scenario 'successfully' do
    # Arrange
    company = create(:company)
    job = create(:job, company: company)
    candidate = create(:candidate)

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on 'Vagas'
    click_on job.title
    click_on 'Candidate-se para esta vaga'
    click_on 'Confirmar candidatura'

    # Assert
    expect(current_path).to eq(job_path(job))
    expect(page).to have_content('Candidatura realizada com sucesso')
    expect(page).to have_link('Acompanhar candidatura')
  end

  scenario 'and can not apply more than once' do
    # Arrange
    company = create(:company)
    job = create(:job, company: company)
    candidate = create(:candidate)
    JobApplication.create!(job: job, candidate: candidate)

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on 'Vagas'
    click_on job.title

    # Assert
    expect(current_path).to eq(job_path(job))
    expect(page).to have_link('Acompanhar candidatura')
    expect(page).not_to have_link('Candidate-se para esta vaga')
  end
end
