require 'rails_helper' 

feature 'Candidate views applications' do
    scenario 'must be signed in' do
      visit root_path
      click_on 'Acesso candidatos'

      expect(current_path).to eq(new_candidate_session_path)
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
      application = Application.create!(job: job, candidate: candidate)

      login_as candidate, scope: :candidate
      visit root_url
      click_on candidate.email

      expect(page).to have_content('Minhas candidaturas')
      expect(page).to have_link('Desenvolvedor(a) Web')
    end
    
    scenario 'and can withdrawl application' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  domain: 'campuscode.com.br')
        job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                          remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                          expiration_date: '06/09/2021', spots_available: 4, company: company)
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')
        application = Application.create!(job: job, candidate: candidate)
  
        login_as candidate, scope: :candidate
        visit root_url
        click_on candidate.email
        click_on job.title
        click_on 'Retirar candidatura'
  
        expect(current_path).to eq(candidates_path)
        expect(page).to have_content('Minhas candidaturas: 0')
      end
end