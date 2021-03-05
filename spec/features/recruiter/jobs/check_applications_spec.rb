require 'rails_helper'

feature 'Recruiter checks incoming applications' do
    scenario 'must be signed in' do
        visit root_path
        click_on 'Acesso recrutadores'

        expect(current_path).to eq(new_recruiter_session_path)
    end
    
    scenario 'successfully' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: 'tr4b4lh0', company: company)
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company, status: :enabled)
      candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                    email: 'maria@email.com.br', password: '234567')
      application = JobApplication.create!(job: job, candidate: candidate, status: :pending)

      login_as recruiter, scope: :recruiter
      visit root_path
      click_on recruiter.email
      click_on job.title
      click_on 'Avaliar candidaturas'

      expect(current_path).to eq(job_job_applications_path(job))
      expect(page).to have_content('Maria Oliveira')
      expect(page).to have_content('Candidaturas pendentes: 1')
      expect(page).to have_link('Enviar proposta')
      expect(page).to have_link('Declinar candidatura')
    end

    scenario 'and can not see applications to other companies' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
                                  domain: 'treinadev.com.br')
        recruiter = Recruiter.create!(email: 'rh@treinadev.com.br', password: 'tr4b4lh0', company: company)
        other_company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                        cnpj: '11.222.555/0000-44', website: 'campuscode.com.br',
                        domain: 'campuscode.com.br')
        other_company_job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                                        expiration_date: '06/09/2021', spots_available: 4, company: other_company)
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')
        application = JobApplication.create!(job: other_company_job, candidate: candidate)

        login_as recruiter, scope: :recruiter
        visit root_path
        click_on 'Ver vagas'
        click_on other_company_job.title

        expect(page).not_to have_link('Avaliar candidaturas')
    end
end