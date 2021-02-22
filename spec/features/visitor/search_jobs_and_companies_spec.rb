require 'rails_helper'

feature 'Visit home page' do
  context 'and search for company' do
    scenario 'successfully' do
        first_company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                        cnpj: '11.222.333/0000-44', website: 'www.campuscode.com.br',
                                        domain: 'campuscode.com.br')
        second_company = Company.create!(name: 'TreinaDev', address: 'Alameda Santos, 1293',
                                         cnpj: '11.333.222/0000-44', website: 'www.treinadev.com.br',
                                         domain: 'treinadev.com.br')
        third_company = Company.create!(name: 'Dev Lab', address: 'Alameda Campinas, 123',
                                        cnpj: '11.222.333/5555-44', website: 'www.devlab.com.br',
                                        domain: 'devlab.com.br')
        
        visit root_path
        fill_in 'Encontre vagas', with: 'Campus Code'
        click_on 'Pesquisar'

        expect(current_path).to eq search_path
        expect(page).to have_content('Campus Code')
        expect(page).to have_content('www.campuscode.com.br')
        expect(page).not_to have_content('TreinaDev')
        expect(page).not_to have_content('Dev Lab')
    end
  end

  context 'and search for job' do
    scenario 'successfully' do
      company = Company.create!(name: 'Dev Lab', address: 'Alameda Campinas, 123',
                                cnpj: '11.222.333/5555-44', website: 'www.devlab.com.br',
                                domain: 'devlab.com.br')
      first_job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de app web', 
                              remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                              expiration_date: '06/09/2021', spots_available: 4, company: company)
      second_job = Job.create!(title: 'Desenvolvedor(a) Mobile', description: 'Desenvolvimento de app mobile', 
                               remuneration: 2500, level: 'Júnior', requirements: 'Flutter',
                               expiration_date: '06/09/2021', spots_available: 4, company: company)
      third_job = Job.create!(title: 'Tech Lead', description: 'Desenvolvimento de software e gestão de equipes', 
                              remuneration: 5000, level: 'Pleno', requirements: 'Ruby on Rails',
                              expiration_date: '06/09/2021', spots_available: 4, company: company)

      visit root_path
      fill_in 'Encontre vagas', with: 'Desenvolvedor'
      click_on 'Pesquisar'

      expect(current_path).to eq search_path
      expect(page).to have_content('Desenvolvedor(a) Web')
      expect(page).to have_content('Desenvolvedor(a) Mobile')
      expect(page).to have_content('Dev Lab')
      expect(page).not_to have_content('Tech Lead')
      expect(page).not_to have_content('Desenvolvimento de software e gestão de equipes')
    end
  end
end