require 'rails_helper'

feature 'Recruiter registers company info' do
    scenario 'from home page' do
        visit root_url
        click_on 'Cadastre-se'
        fill_in 'E-mail', with: 'rh@campuscode.com.br'
        fill_in 'Senha', with: 'tr4b4lh0'
        fill_in 'Confirme a senha', with: 'tr4b4lh0'
        click_on 'Cadastrar'

        expect(current_path).to eq(new_company_path)
    end

    scenario 'successfully' do
        visit root_url
        click_on 'Cadastre-se'
        fill_in 'E-mail', with: 'rh@campuscode.com.br'
        fill_in 'Senha', with: 'tr4b4lh0'
        fill_in 'Confirme a senha', with: 'tr4b4lh0'
        click_on 'Cadastrar'
        within('form') do 
            fill_in 'Nome', with: 'Campus Code'
            fill_in 'Endereço', with: 'Alameda Santos, 1293'
            fill_in 'CNPJ', with: '11.222.333/0000-44'
            fill_in 'Site', with: 'www.campuscode.com.br'
            fill_in 'Domínio de e-mail dos funcionários', with: 'www.campuscode.com.br'
            attach_file 'Logo', Rails.root.join('spec', 'support', 'logo_cc.jpg')
            click_on 'Salvar'
        end

        expect(page).to have_content('Painel do recrutador - Campus Code')
        expect(page).to have_link('Publicar vagas')
        expect(page).to have_link('Sair')
    end

    scenario 'and must fill all required fields' do
        visit root_url
        click_on 'Cadastre-se'
        fill_in 'E-mail', with: 'rh@campuscode.com.br'
        fill_in 'Senha', with: 'tr4b4lh0'
        fill_in 'Confirme a senha', with: 'tr4b4lh0'
        click_on 'Cadastrar'
        within('form') do 
            fill_in 'Nome', with: ''
            fill_in 'Endereço', with: ''
            fill_in 'CNPJ', with: ''
            fill_in 'Site', with: ''
            fill_in 'Domínio de e-mail dos funcionários', with: ''
            attach_file 'Logo', Rails.root.join('spec', 'support', 'logo_cc.jpg')
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível registrar a empresa')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Endereço não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('Site não pode ficar em branco')
        expect(page).not_to have_content('Painel do recrutador - Campus Code')
    end

    scenario 'and name and CNPJ must be unique' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Anjos, 1345',
                                 cnpj: '11.222.333/0000-44', website: 'www.campuscode.com', 
                                 domain: 'campuscode.com' )

                                 
        visit root_url
        click_on 'Cadastre-se'
        fill_in 'E-mail', with: 'rh@campuscode.com.br'
        fill_in 'Senha', with: 'tr4b4lh0'
        fill_in 'Confirme a senha', with: 'tr4b4lh0'
        click_on 'Cadastrar'
        within('form') do 
          fill_in 'Nome', with: 'Campus Code'
          fill_in 'Endereço', with: 'Alameda Santos, 1293'
          fill_in 'CNPJ', with: '11.222.333/0000-44'
          fill_in 'Site', with: 'www.campuscode.com.br'
          fill_in 'Domínio de e-mail dos funcionários', with: 'campuscode.com.br'
          attach_file 'Logo', Rails.root.join('spec', 'support', 'logo_cc.jpg')
          click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível registrar a empresa')
        expect(page).to have_content('Nome já está em uso')
        expect(page).to have_content('CNPJ já está em uso')
        expect(page).not_to have_content('Painel do recrutador - Campus Code')
    end

    scenario 'and next recruiters will automatically join the company' do
        first_recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456')
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'www.campuscode.com.br', 
                                  domain: 'campuscode.com.br')
        
        visit root_path
        click_on 'Cadastre-se'
        fill_in 'E-mail', with: 'dev@campuscode.com.br'
        fill_in 'Senha', with: 'tr4b4lh0'
        fill_in 'Confirme a senha', with: 'tr4b4lh0'
        click_on 'Cadastrar'

        expect(current_path).to eq(company_path(company))
        expect(page).to have_content('Painel do recrutador - Campus Code')
        expect(page).to have_link('Sair')
        expect(page).not_to have_content('Cadastro de empresa')
    end
end