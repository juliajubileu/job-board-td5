require 'rails_helper'

feature 'Visit home page' do
  context 'and search for company' do
    scenario 'successfully' do
      create(:company)
      create(:company, name: 'TreinaDev', address: 'Alameda Santos, 1293',
                       cnpj: '11.333.222/0000-44',
                       website: 'www.treinadev.com.br',
                       domain: 'treinadev.com.br')
      create(:company, name: 'Dev Lab', address: 'Alameda Campinas, 123',
                       cnpj: '11.222.333/5555-44', website: 'www.devlab.com.br',
                       domain: 'devlab.com.br')

      # Act
      visit root_path
      within('form') do
        fill_in 'Busque um cargo ou empresa', with: 'Campus'
      end
      click_on 'Pesquisar'

      # Assert
      expect(current_path).to eq search_path
      expect(page).to have_content('Campus Code')
      expect(page).to have_content('www.campuscode.com.br')
      expect(page).not_to have_content('TreinaDev')
      expect(page).not_to have_content('Dev Lab')
    end
  end

  context 'and search for job' do
    scenario 'successfully' do
      # Arrange
      company = create(:company)
      create(:job, title: 'Desenvolvedor(a) Web', company: company)
      create(:job, title: 'Desenvolvedor(a) Mobile', company: company)
      create(:job, title: 'Tech Lead', company: company)

      # Act
      visit root_path
      within('form') do
        fill_in 'Busque um cargo ou empresa', with: 'Desenvolvedor'
      end
      click_on 'Pesquisar'

      # Assert
      expect(current_path).to eq search_path
      expect(page).to have_content('Desenvolvedor(a) Web')
      expect(page).to have_content('Desenvolvedor(a) Mobile')
      expect(page).to have_content('Campus Code')
      expect(page).not_to have_content('Tech Lead')
    end
  end
end
