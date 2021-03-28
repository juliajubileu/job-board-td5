require 'rails_helper'

feature 'Candidate reviews offers' do
  scenario 'from home page' do
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
    click_on 'Avaliar oferta'

    # Assert
    expect(page).to have_link('Aceitar oferta')
    expect(page).to have_link('Declinar oferta')
  end

  scenario 'and can decline offer' do
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
    click_on 'Avaliar oferta'
    click_on 'Declinar oferta'
    within('form') do
      fill_in 'Conte o motivo para recusar a oferta', with: 'Já aceitei outra
                                                            proposta.'
      click_on 'Enviar'
    end

    # Assert
    expect(page).to have_content('Oferta recusada')
    expect(page).not_to have_link('Avaliar oferta')
  end

  scenario 'and must state reason for denial' do
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
    click_on 'Avaliar oferta'
    click_on 'Declinar oferta'
    within('form') do
      fill_in 'Conte o motivo para recusar a oferta', with: ''
      click_on 'Enviar'
    end

    # Assert
    expect(page).to have_content('Não foi possível recusar oferta')
    expect(page).to have_content('Motivo não pode ficar em branco')
  end

  scenario 'and can accept offer' do
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
    click_on 'Avaliar oferta'
    click_on 'Aceitar oferta'

    # Assert
    expect(page).to have_content('Parabéns pela contratação!')
    expect(page).not_to have_link('Avaliar oferta')
  end
end
