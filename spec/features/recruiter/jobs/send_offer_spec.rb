require 'rails_helper'

feature 'Recruiter sends offer to candidate' do
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
      click_on 'Enviar proposta'
      within('form') do
        fill_in 'Mensagem de aprovação', with: 'Você foi aprovada no processo seletivo!'
        fill_in 'Oferta de remuneração', with: 2500
        fill_in 'Data de início', with: '01/04/2021'
        click_on 'Enviar proposta'
      end

      application.reload
      expect(current_path).to eq(job_applications_path(job))
      expect(page).to have_content('Candidaturas aprovadas: 1')
      expect(page).to have_content('Candidaturas pendentes: 0')
      expect(application.approved?).to be_truthy
    end

    scenario 'and must fill all fields' do
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
        click_on 'Enviar proposta'
        within('form') do
          fill_in 'Mensagem de aprovação', with: ''
          fill_in 'Oferta de remuneração', with: ''
          fill_in 'Data de início', with: ''
          click_on 'Enviar proposta'
        end
      
        expect(page).to have_content('Não foi possível enviar oferta')
        expect(page).to have_content('Mensagem não pode ficar em branco')
        expect(page).to have_content('Remuneração não pode ficar em branco')
        expect(page).to have_content('Data de início não pode ficar em branco')
        expect(application.pending?).to be_truthy
    end

    scenario 'and starting date must be in the future' do
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
        click_on 'Enviar proposta'
        within('form') do
            fill_in 'Mensagem de aprovação', with: 'Você foi aprovada no processo seletivo!'
            fill_in 'Oferta de remuneração', with: 2500
            fill_in 'Data de início', with: '01/04/2001'
            click_on 'Enviar proposta'
        end
      
        expect(page).to have_content('Não foi possível enviar oferta')
        expect(page).to have_content('Data de início deve ser futura')
        expect(application.pending?).to be_truthy
    end

    scenario 'and salary must be higher than minimum wage' do
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
        click_on 'Enviar proposta'
        within('form') do
            fill_in 'Mensagem de aprovação', with: 'Você foi aprovada no processo seletivo!'
            fill_in 'Oferta de remuneração', with: 500
            fill_in 'Data de início', with: '01/04/2021'
            click_on 'Enviar proposta'
        end
      
        expect(page).to have_content('Não foi possível enviar oferta')
        expect(page).to have_content('Oferta de remuneração deve ser maior que salário mínimo (R$1.100,00)')
        expect(application.pending?).to be_truthy
    end

    scenario 'hide button if offer sent' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                 cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                 domain: 'campuscode.com.br')
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: 'tr4b4lh0', company: company)
        job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                          remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                          expiration_date: '06/09/2021', spots_available: 4, company: company, status: :enabled)
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')
        application = Application.create!(job: job, candidate: candidate, status: :approved)
  
        login_as recruiter, scope: :recruiter
        visit root_path
        click_on recruiter.email
        click_on job.title
        click_on 'Avaliar candidaturas'
  
        expect(page).to have_content('Candidaturas aprovadas: 1')
        expect(page).not_to have_link('Enviar proposta')
    end
end