require 'rails_helper'

feature 'Visitor visits home page' do
    scenario 'Successfully' do
        visit root_path

        expect(page).to have_content('Encontre seu próximo trabalho em tecnologia!')
    end

    scenario 'and sees companies' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company)

      visit root_path
      click_on 'Empresas'

      expect(current_path).to eq(companies_path)
      expect(page).to have_link('Campus Code')
    end

    scenario 'and sees jobs' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company)

      visit root_path
      click_on 'Vagas'

     expect(current_path).to eq(jobs_path)
     expect(page).to have_link('Desenvolvedor(a) Web')
     expect(page).to have_content('Desenvolvimento de aplicações web')
    end
end