require 'rails_helper'

feature 'Recruiter registers company info' do
    scenario 'from home page' do
        visit root_url
        click_on 'Cadastre-se'
        fill_in 'E-mail', with: 'rh@treinadev.com.br'
        fill_in 'Senha', with: 'tr4b4lh0'
        fill_in 'Confirme a senha', with: 'tr4b4lh0'
        click_on 'Cadastrar'

        expect(current_path).to eq(new_company_path)
    end

    scenario 'successfully' do
        first_recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456')

        login_as first_recruiter, scope: :recruiter
        click_on 'Inserir dados da empresa'
        within('form') do 
            fill_in 'Nome', with: 'Campus Code'
            fill_in 'Endereço', with: 'Alameda Santos, 1293'
            fill_in 'CNPJ', with: '11.222.333/0000-44'
            fill_in 'Site', with: 'www.campuscode.com.br'
            fill_in 'Redes Sociais', with: 'twitter.com/campuscode'
            attach_file 'Logomarca', Rails.root.join('spec', 'support', 'logo_cc.jpg')
            click_on 'Salvar'
        end

        expect(page).to have_content('Campus Code cadastrada com sucesso')
        expect(page).to have_link('Publicar vagas')
        expect(page).to have_link('Sair')
    end

    scenario 'and must fill all required fields' do
        first_recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456')

        login_as first_recruiter, scope: :recruiter
        click_on 'Inserir dados da empresa'
        within('form') do 
            fill_in 'Nome', with: ''
            fill_in 'Endereço', with: ''
            fill_in 'CNPJ', with: ''
            fill_in 'Site', with: ''
            fill_in 'Redes Sociais', with: ''
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível registrar a empresa')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Endereço não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('Site não pode ficar em branco')
        expect(page).not_to have_content('Campus Code cadastrada com sucesso')
    end

    scenario 'and name and CNPJ must be unique' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Anjos, 1345',
                                 cnpj: 11222333000044, website: 'campuscode.com',
        social: 'twitter.com/campuscode')
        first_recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456')

        login_as first_recruiter, scope: :recruiter
        click_on 'Inserir dados da empresa'
        within('form') do 
            fill_in 'Nome', with: 'Campus Code'
            fill_in 'Endereço', with: 'Alameda Santos, 1293'
            fill_in 'CNPJ', with: '11.222.333/0000-44'
            fill_in 'Site', with: 'www.campuscode.com.br'
            fill_in 'Redes Sociais', with: 'twitter.com/campuscode'
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível registrar a empresa')
        expect(page).to have_content('Nome já está em uso')
        expect(page).to have_content('CNPJ já está em uso')
        expect(page).not_to have_content('Campus Code cadastrada com sucesso')
    end

    scenario 'and next recruiters will automatically join the company' do
        first_recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456')
        second_recruiter = Recruiter.create!(email: 'dev@campuscode.com.br', password: '654321')

        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  social: 'twitter.com/campuscode', admin: first_recruiter)
        
        login_as second_recruiter, scope: :recruiter
        visit root_path
        click_on 'Entrar'

        expect(current_path).to eq(company_dashboard_path)
        expect(page).to have_content('Painel do recrutador - Campus Code')
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Inserir dados da empresa')
    end
end