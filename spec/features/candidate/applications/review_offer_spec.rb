require 'rails_helper' 

feature 'Candidate reviews offers' do
    scenario 'from home page' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  domain: 'campuscode.com.br')
        job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                          remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                           expiration_date: '06/09/2021', spots_available: 4, company: company, status: :enabled)
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')
        application = Application.create!(job: job, candidate: candidate, status: :approved)
        offer = Offer.create!(message: 'Parabéns', salary: 2500, starting_date: '05/04/2021', application: application, status: :pending)

        login_as candidate, scope: :candidate
        visit root_url
        click_on candidate.email
        click_on 'Avaliar oferta'

        expect(page).to have_link('Aceitar oferta')
        expect(page).to have_link('Declinar oferta')
    end

    scenario 'and can decline offer' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  domain: 'campuscode.com.br')
        job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                          remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                           expiration_date: '06/09/2021', spots_available: 4, company: company, status: :enabled)
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')
        application = Application.create!(job: job, candidate: candidate, status: :approved)
        offer = Offer.create!(message: 'Parabéns', salary: 2500, starting_date: '05/04/2021', application: application, status: :pending)

        login_as candidate, scope: :candidate
        visit root_url
        click_on candidate.email
        click_on 'Avaliar oferta'
        click_on 'Declinar oferta'
        within('form') do
            fill_in 'Conte o motivo para recusar a oferta', with: 'Já aceitei outra proposta.'
            click_on 'Enviar'
        end

        expect(page).to have_content('Oferta recusada')
        expect(page).not_to have_link('Avaliar oferta')
    end

    scenario 'and must state reason for denial' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                 cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                 domain: 'campuscode.com.br')
        job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                          remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                          expiration_date: '06/09/2021', spots_available: 4, company: company, status: :enabled)
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')
        application = Application.create!(job: job, candidate: candidate, status: :approved)
        offer = Offer.create!(message: 'Parabéns', salary: 2500, starting_date: '05/04/2021', application: application, status: :pending)

        login_as candidate, scope: :candidate
        visit root_url
        click_on candidate.email
        click_on 'Avaliar oferta'
        click_on 'Declinar oferta'
        within('form') do
            fill_in 'Conte o motivo para recusar a oferta', with: ''
            click_on 'Enviar'
        end

        expect(page).to have_content('Não foi possível recusar oferta')
        expect(page).to have_content('Motivo não pode ficar em branco')
    end

    scenario 'and can accept offer' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                 cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                 domain: 'campuscode.com.br')
        job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                          remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                          expiration_date: '06/09/2021', spots_available: 4, company: company, status: :enabled)
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',  bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')
        application = Application.create!(job: job, candidate: candidate, status: :approved)
        offer = Offer.create!(message: 'Parabéns', salary: 2500, starting_date: '05/04/2021', application: application, status: :pending)

        login_as candidate, scope: :candidate
        visit root_url
        click_on candidate.email
        click_on 'Avaliar oferta'
        click_on 'Aceitar oferta'

        expect(page).to have_content('Parabéns pela contratação!')
        expect(page).not_to have_link('Avaliar oferta')
    end
end