require 'rails_helper'

xfeature 'Recruiter edits password' do
    scenario 'successfully' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
                                   domain: 'treinadev.com.br')
        recruiter = Recruiter.create!(email: 'rh@treinadev', password: '124567', company: company)
        
        login_as recruiter, scope: :recruiter
        visit root_url
        click_on 'Painel do recrutador'
        click_on 'Atualizar senha'
        within('form') do
          fill_in 'Senha anterior', with: '124567'
          fill_in 'Nova senha', with: '654321'
          fill_in 'Confirme a nova senha', with: '654321'
        end

        expect(page).to have_content('Senha atualizada com sucesso')
        expect(page).to have_content('rh@treinadev.com.br')
        expect(page).to have_link('Sair')
    end

    scenario 'and new password can not be blank' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
                                  domain: 'treinadev.com.br')
        recruiter = Recruiter.create!(email: 'rh@treinadev', password: '124567', company: company)
        
        login_as recruiter, scope: :recruiter
        visit root_url
        click_on 'Painel do recrutador'
        click_on 'Atualizar senha'
        within('form') do
          fill_in 'Senha anterior', with: '124567'
          fill_in 'Nova senha', with: ''
          fill_in 'Confirme a nova senha', with: ''
        end

        expect(page).to have_content('Não foi possível atualizar senha')
        expect(page).to have_content('Senha não pode ficar em branco')
        expect(page).to have_link('Sair')
    end

    scenario 'and password must match confirmation' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
                                  domain: 'treinadev.com.br')
        recruiter = Recruiter.create!(email: 'rh@treinadev', password: '124567', company: company)
        
        login_as recruiter, scope: :recruiter
        visit root_url
        click_on 'Painel do recrutador'
        click_on 'Atualizar senha'
        within('form') do
          fill_in 'Senha anterior', with: '124567'
          fill_in 'Nova senha', with: '123456'
          fill_in 'Confirme a nova senha', with: '234567'
        end

        expect(page).to have_content('Não foi possível atualizar senha')
        expect(page).to have_content('Confirmação de senha não é igual a senha')
        expect(page).to have_link('Sair')
    end
end