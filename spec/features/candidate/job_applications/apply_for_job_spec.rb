require 'rails_helper'

feature 'Candidate applies for job' do
    scenario 'From home page' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company)
      candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                    email: 'maria@email.com.br', password: '234567')
      
      login_as candidate, scope: :candidate
      visit root_url
      click_on 'Ver vagas'
      click_on job.title

      expect(page).to have_link('Candidate-se para esta vaga')
    end

    scenario 'successfully' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company)
      candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                    email: 'maria@email.com.br', password: '234567')

      login_as candidate, scope: :candidate
      visit root_url
      click_on 'Ver vagas'
      click_on job.title
      click_on 'Candidate-se para esta vaga'
      click_on 'Confirmar candidatura'

      expect(current_path).to eq(job_path(job))
      expect(page).to have_content('Candidatura realizada com sucesso')
      expect(page).to have_link('Acompanhar candidatura')
    end

    scenario 'and can not apply more than once' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company)
      candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                    email: 'maria@email.com.br', password: '234567')
      application = JobApplication.create!(job: job, candidate: candidate)

      login_as candidate, scope: :candidate
      visit root_url
      click_on 'Ver vagas'
      click_on job.title

      expect(current_path).to eq(job_path(job))
      expect(page).to have_link('Acompanhar candidatura')
      expect(page).not_to have_link('Candidate-se para esta vaga')
    end
end