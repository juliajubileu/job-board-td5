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
                        expiration_date: '06/09/2021', spots_available: 4, company: company)

      login_as recruiter, scope: :recruiter
      visit root_path
      click_on recruiter.email
      click_on 'Minha empresa'
      click_on job.title
      click_on 'Desativar vaga'

      job.reload
      expect(page).to have_content('Vagas desativadas: 1')
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
      click_on 'Minha empresa'
      click_on 'Ver detalhes'
      click_on 'Ativar vaga'
      click_on job.title

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
end