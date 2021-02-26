require 'rails_helper'

feature 'Recruiter rejects candidate' do
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
      application = Application.create!(job: job, candidate: candidate, status: :pending)

      login_as recruiter, scope: :recruiter
      visit root_path
      click_on recruiter.email
      click_on job.title
      click_on 'Avaliar candidaturas'
      click_on 'Declinar candidatura'
      within('form') do
        fill_in 'Motivo da reprovação', with: 'Você não foi aprovado para a vaga!'
        click_on 'Enviar'
      end

      expect(current_path).to eq(job_applications_path(job))
      expect(page).to have_content('Candidaturas rejeitadas: 1')
      expect(page).to have_content('Candidaturas pendentes: 0')
      application.reload
      expect(application.rejected?).to be_truthy
    end

    scenario 'and must send a motive' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                     cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                     domain: 'campuscode.com.br')
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: 'tr4b4lh0', company: company)
        job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                              remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                              expiration_date: '06/09/2021', spots_available: 4, company: company, status: :enabled)
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                          email: 'maria@email.com.br', password: '234567')
        application = Application.create!(job: job, candidate: candidate, status: :pending)
      
        login_as recruiter, scope: :recruiter
        visit root_path
        click_on recruiter.email
        click_on job.title
        click_on 'Avaliar candidaturas'
        click_on 'Declinar candidatura'
        within('form') do
            fill_in 'Motivo da reprovação', with: ''
            click_on 'Enviar'
        end
      
        expect(page).to have_content('Não foi possível rejeitar candidatura')
        expect(page).to have_content('Motivo não pode ficar em branco')
        expect(application.pending?).to be_truthy
    end

    scenario 'hide button if application rejected' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                 cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                 domain: 'campuscode.com.br')
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: 'tr4b4lh0', company: company)
        job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                          remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                          expiration_date: '06/09/2021', spots_available: 4, company: company, status: :enabled)
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')
        application = Application.create!(job: job, candidate: candidate, status: :rejected)
  
        login_as recruiter, scope: :recruiter
        visit root_path
        click_on recruiter.email
        click_on job.title
        click_on 'Avaliar candidaturas'
  
        expect(page).to have_content('Candidaturas rejeitadas: 1')
        expect(page).not_to have_link('Enviar proposta')
    end
end