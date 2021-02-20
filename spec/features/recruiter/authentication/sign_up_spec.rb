require 'rails_helper'

feature 'Recruiter signs up' do
    scenario 'from the home page' do
        visit root_url

        expect(page).to have_link 'Acesso recrutadores'
    end

    scenario 'successfully' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
        cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
        domain: 'treinadev.com.br')
        
        visit root_url
        click_on 'Acesso recrutadores'
        click_on 'Registre-se'
        within('form') do
          fill_in 'E-mail', with: 'rh@treinadev.com.br'
          fill_in 'Senha', with: 'tr4b4lh0'
          fill_in 'Confirme a senha', with: 'tr4b4lh0'
          click_on 'Salvar'
        end

        expect(page).to have_content('rh@treinadev.com.br')
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Acesso recrutadores')
    end

    scenario 'and password can not be blank' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
        cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
        domain: 'treinadev.com.br')

        visit root_url
        click_on 'Acesso recrutadores'
        click_on 'Registre-se'
        within('form') do
          fill_in 'E-mail', with: 'rh@treinadev.com.br'
          fill_in 'Senha', with: ''
          fill_in 'Confirme a senha', with: ''
          click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível salvar recrutador')
        expect(page).to have_content('não pode ficar em branco')
        expect(page).not_to have_content('rh@treinadev.com.br')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and password must match confirmation' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
        cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
        domain: 'treinadev.com.br')
        
        visit root_url
        click_on 'Acesso recrutadores'
        click_on 'Registre-se'
        within('form') do
            fill_in 'E-mail', with: 'rh@treinadev.com.br'
            fill_in 'Senha', with: 'tr4b4lh0'
            fill_in 'Confirme a senha', with: '123456'
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível salvar recrutador')
        expect(page).to have_content('Confirmação de senha não é igual a Senha')
        expect(page).not_to have_content('rh@treinadev.com.br')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and email must be valid' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
        cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
        domain: 'treinadev.com.br')
        
        visit root_url
        click_on 'Acesso recrutadores'
        click_on 'Registre-se'
        within('form') do
            fill_in 'E-mail', with: 'rh'
            fill_in 'Senha', with: 'tr4b4lh0'
            fill_in 'Confirme a senha', with: 'tr4b4lh0'
            click_on 'Salvar'
        end
        
        expect(page).to have_content('Não foi possível salvar recrutador')
        expect(page).to have_content('E-mail não é válido')
        expect(page).not_to have_content('rh@treinadev.com.br')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and email can not be at use' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
                                  domain: 'treinadev.com.br')
        recruiter = Recruiter.create!(email: 'rh@treinadev.com.br', password: 'tr4b4lh0', company: company)
        
        visit root_url
        click_on 'Acesso recrutadores'
        click_on 'Registre-se'
        within('form') do
            fill_in 'E-mail', with: 'rh@treinadev.com.br'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirme a senha', with: '123456'
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível salvar recrutador')
        expect(page).to have_content('já está em uso')
        expect(page).not_to have_content('rh@treinadev.com.br')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and must be corporate email' do
        visit root_url
        click_on 'Acesso recrutadores'
        click_on 'Registre-se'
        within('form') do
            fill_in 'E-mail', with: 'julia@gmail.com'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirme a senha', with: '123456'
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível salvar recrutador')
        expect(page).to have_content('Não é e-mail corporativo')
        expect(page).not_to have_content('julia@gmail.com')
        expect(page).not_to have_link('Sair')
    end
end