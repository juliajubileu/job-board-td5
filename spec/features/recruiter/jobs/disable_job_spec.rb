require 'rails_helper'

feature 'Recruiter disables a job' do
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

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on recruiter.email
    click_on job.title
    click_on 'Desativar vaga'
    job.reload

    # Assert
    expect(page).to have_content('Vaga desativada')
    expect(page).to have_link('Ativar vaga')
    expect(job).to be_disabled
  end

  scenario 'and can enable job again' do
    # Arrange
    company = create(:company)
    recruiter = create(:recruiter, email: 'rh@campuscode.com.br',
                                   company: company)
    job = create(:job, company: company, status: :disabled)

    # Act
    login_as recruiter, scope: :recruiter
    visit root_path
    click_on recruiter.email
    click_on job.title
    click_on 'Ativar vaga'
    job.reload

    # Assert
    expect(page).to have_link('Desativar vaga')
    expect(job).to be_enabled
  end

  scenario 'and disabled job can not be seen by visitors' do
    company = create(:company)
    create(:job, company: company, status: :enabled)
    create(:job, company: company, title: 'Desenvolvedor(a) Mobile',
                 status: :disabled)

    # Act
    visit root_path
    click_on 'Vagas'

    # Assert
    expect(page).to have_content('Desenvolvedor(a) Web')
    expect(page).not_to have_content('Desenvolvedor(a) Mobile')
  end
end
