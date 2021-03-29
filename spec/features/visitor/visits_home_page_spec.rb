require 'rails_helper'

feature 'Visitor visits home page' do
  scenario 'Successfully' do
    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Encontre seu próximo trabalho em tecnologia!')
  end

  scenario 'and sees companies' do
    # Arrange
    company = create(:company)
    create(:job, company: company)

    # Act
    visit root_path
    click_on 'Empresas'

    # Assert
    expect(current_path).to eq(companies_path)
    expect(page).to have_link('Campus Code')
  end

  scenario 'and sees jobs' do
    # Arrange
    company = create(:company)
    create(:job, company: company)

    # Act
    visit root_path
    click_on 'Vagas'

    # Assert
    expect(current_path).to eq(jobs_path)
    expect(page).to have_link('Desenvolvedor(a) Web')
    expect(page).to have_content('Desenvolvimento de aplicações web')
  end
end
