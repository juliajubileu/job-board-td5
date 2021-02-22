require 'rails_helper'

xfeature 'Candidate edits profile' do
    scenario 'successfully' do     
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',
                                      email: 'maria@email.com.br', password: '234567')

        login_as candidate, scope: :candidate
        visit root_url
        click_on candidate.email
        click_on 'Atualizar perfil'
        within('form') do
          fill_in 'Nome completo', with: 'Maria da Silva'
          fill_in 'Nome social', with: 'Maria'
          fill_in 'Senha', with: '123456'
          fill_in 'Confirme a senha', with: '123456'
          click_on 'Salvar'
        end

        expect(page).to have_content('Perfil atualizado com sucesso')
        expect(page).to have_content('maria@email.com')
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Acesso candidatos')
        expect(page).not_to have_link('Acesso recrutadores')
    end

    scenario 'and password can not be blank' do
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',
                                      email: 'maria@email.com.br', password: '234567')

        login_as candidate, scope: :candidate
        visit root_url
        click_on candidate.email
        click_on 'Atualizar perfil'
        within('form') do
            fill_in 'Nome completo', with: 'Maria da Silva'
            fill_in 'Nome social', with: 'Maria'
            fill_in 'Senha', with: ''
            fill_in 'Confirme a senha', with: ''
            click_on 'Salvar'
          end

        expect(page).to have_content('Não foi possível atualizar o perfil')
        expect(page).to have_content('Senha não pode ficar em branco')
        expect(page).not_to have_content('maria@email.com')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and password must match confirmation' do
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312',
                                      email: 'maria@email.com.br', password: '234567')

        login_as candidate, scope: :candidate
        visit root_url
        click_on candidate.email
        click_on 'Atualizar perfil'
        within('form') do
          fill_in 'Nome completo', with: 'Maria da Silva'
          fill_in 'Nome social', with: 'Maria'
          fill_in 'Senha', with: '123456'
          fill_in 'Confirme a senha', with: '654321'
          click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível atualizar o perfil')
        expect(page).to have_content('Confirmação de senha não é igual a Senha')
        expect(page).not_to have_content('maria@email.com')
        expect(page).not_to have_link('Sair')
    end
end