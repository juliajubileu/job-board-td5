require 'rails_helper'

feature 'Candidate signs up' do
    scenario 'from the home page' do
        visit root_url
        click_on 'Acesso candidatos'

        expect(current_path).to eq(new_candidate_session_path)
    end

    scenario 'and from the job page' do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                domain: 'campuscode.com.br')
        job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                        remuneration: 2500, level: 'Júnior', requirements: 'Ruby on Rails',
                        expiration_date: '06/09/2021', spots_available: 4, company: company)

        visit root_url
        click_on 'Ver vagas'
        click_on job.title
        click_on 'Candidate-se para esta vaga'

        expect(current_path).to eq(new_candidate_session_path)
    end

    scenario 'successfully' do        
        visit root_url
        click_on 'Acesso candidatos'
        click_on 'Registre-se'
        within('form') do
          fill_in 'Nome completo', with: 'Maria da Silva'
          fill_in 'Nome social', with: ''
          fill_in 'CPF', with: '1234560984'
          fill_in 'E-mail', with: 'maria@email.com'
          fill_in 'Senha', with: '123456'
          fill_in 'Confirmação de senha', with: '123456'
          click_on 'Salvar'
        end

        expect(page).to have_content('maria@email.com')
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Acesso candidatos')
        expect(page).not_to have_link('Acesso recrutadores')
    end

    scenario 'and password can not be blank' do
        visit root_url
        click_on 'Acesso candidatos'
        click_on 'Registre-se'
        within('form') do
            fill_in 'Nome completo', with: 'Maria da Silva'
            fill_in 'Nome social', with: ''
            fill_in 'CPF', with: '1234560984'
            fill_in 'E-mail', with: 'maria@email.com'
            fill_in 'Senha', with: ''
            fill_in 'Confirmação de senha', with: ''
            click_on 'Salvar'
          end

        expect(page).to have_content('Não foi possível salvar candidato')
        expect(page).to have_content('Senha não pode ficar em branco')
        expect(page).not_to have_content('maria@email.com')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and password must match confirmation' do
        visit root_url
        click_on 'Acesso candidatos'
        click_on 'Registre-se'
        within('form') do
          fill_in 'Nome completo', with: 'Maria da Silva'
          fill_in 'Nome social', with: ''
          fill_in 'CPF', with: '1234560984'
          fill_in 'E-mail', with: 'maria@email.com'
          fill_in 'Senha', with: '123456'
          fill_in 'Confirmação de senha', with: '654321'
          click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível salvar candidato')
        expect(page).to have_content('Confirmação de senha não é igual a Senha')
        expect(page).not_to have_content('maria@email.com')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and email must be valid' do
        visit root_url
        click_on 'Acesso candidatos'
        click_on 'Registre-se'
        within('form') do
          fill_in 'Nome completo', with: 'Maria da Silva'
          fill_in 'Nome social', with: ''
          fill_in 'CPF', with: '1234560984'
          fill_in 'E-mail', with: 'maria'
          fill_in 'Senha', with: '123456'
          fill_in 'Confirmação de senha', with: '123456'
          click_on 'Salvar'
        end
        
        expect(page).to have_content('Não foi possível salvar candidato')
        expect(page).to have_content('E-mail não é válido')
        expect(page).not_to have_content('maria@email.com')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and email can not be at use' do
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',
                                      email: 'maria@email.com.br', password: '234567')
        
        visit root_url
        click_on 'Acesso candidatos'
        click_on 'Registre-se'
        within('form') do
          fill_in 'Nome completo', with: 'Maria da Silva'
          fill_in 'Nome social', with: ''
          fill_in 'CPF', with: '1234560984'
          fill_in 'E-mail', with: 'maria@email.com.br'
          fill_in 'Senha', with: '123456'
          fill_in 'Confirmação de senha', with: '123456'
          click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível salvar candidato')
        expect(page).to have_content('E-mail já está em uso')
        expect(page).not_to have_content('maria@email.com')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and cpf must be unique' do
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',
                                      email: 'maria@email.com.br', password: '234567')
        
        visit root_url
        click_on 'Acesso candidatos'
        click_on 'Registre-se'
        within('form') do
          fill_in 'Nome completo', with: 'Maria da Silva'
          fill_in 'Nome social', with: ''
          fill_in 'CPF', with: '12312312312'
          fill_in 'E-mail', with: 'maria.oliveira@email.com'
          fill_in 'Senha', with: '123456'
          fill_in 'Confirmação de senha', with: '123456'
          click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível salvar candidato')
        expect(page).to have_content('CPF já está em uso')
        expect(page).not_to have_content('maria.oliveira@email.com')
        expect(page).not_to have_link('Sair')
    end
end