require 'rails_helper'

feature 'Recruiter disables a job' do
    scenario 'must be signed in' do
        visit root_path
        click_on 'Acesso recrutadores'

        expect(current_path).to eq(new_recruiter_session_path)
    end

    scenario 'successfully' do 
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456', 
                                    company: company)
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company,
                        status: :enabled)

      login_as recruiter, scope: :recruiter
      visit root_path
      click_on recruiter.email
      click_on job.title
      click_on 'Desativar vaga'

      job.reload
      expect(page).to have_content('Vaga desativada')
      expect(page).to have_link('Ativar vaga')
      expect(job).to be_disabled
    end

    scenario 'and can enable job again' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456', 
                                    company: company)
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company,
                        status: :disabled)

      login_as recruiter, scope: :recruiter
      visit root_path
      click_on recruiter.email
      click_on job.title
      click_on 'Ativar vaga'
  
      job.reload
      expect(page).to have_link('Desativar vaga')
      expect(job).to be_enabled
    end

    scenario 'and disabled job can not be seen by visitors' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      disabled_job = Job.create!(title: 'Desenvolvedor(a) Mobile', description: 'Desenvolvimento de app mobile', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Dev Mobile',
                        expiration_date: '06/10/2021', spots_available: 4, company: company,
                        status: :disabled)
      enabled_job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company,
                        status: :enabled)
      visit root_path
      click_on 'Ver vagas'

      expect(page).to have_content('Desenvolvedor(a) Web')
      expect(page).not_to have_content('Desenvolvedor(a) Mobile')
    end

    xscenario 'and job is automatically disabled after all spots filled' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 2, company: company,
                        status: :enabled)
      first_candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata 1',
                                    email: 'maria@email.com.br', password: '234567')
      first_application = Application.create!(job: job, candidate: first_candidate, status: :approved)
      first_offer = Offer.create!(message: 'parabéns', salary: 2200, starting_date: '23/03/2021', 
                                  application: first_application, status: :accepted)
      second_candidate = Candidate.create!(full_name: 'Mariana Ferreira', cpf: '12312314562',  bio: 'candidata 2',
                                  email: 'mariana@email.com.br', password: '234547')
      second_application = Application.create!(job: job, candidate: second_candidate, status: :approved)
      second_offer = Offer.create!(message: 'parabéns', salary: 2200, starting_date: '23/03/2021', 
                                   application: second_application, status: :accepted)

      visit root_path
      click_on 'Ver vagas'

      job.reload
      expect(job).to be_disabled
      expect(page).to have_content('Desenvolvedor(a) Web')
      expect(page).not_to have_content('Desenvolvedor(a) Mobile')
    end
end