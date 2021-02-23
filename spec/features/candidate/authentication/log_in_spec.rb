require 'rails_helper'

feature 'Candidate log in the platform' do
    scenario 'successfully' do
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312', bio: 'candidata',
                                     email: 'maria@email.com.br', password: '234567')

        visit root_path
        click_on 'Acesso candidatos'
        within('form') do
            fill_in 'E-mail', with: candidate.email
            fill_in 'Senha', with: candidate.password
            click_on 'Entrar'
        end

        expect(page).to have_content candidate.email
        expect(page).to have_content 'Login efetuado com sucesso'
        expect(page).to have_link 'Sair'
        expect(page).not_to have_link 'Acesso candidatos'
    end

    scenario 'and must fill all fields' do
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312', bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')

        visit root_path
        click_on 'Acesso candidatos'
        within('form') do
            fill_in 'E-mail', with: ''
            fill_in 'Senha', with: ''
            click_on 'Entrar'
        end

        expect(page).to have_content 'E-mail ou senha inválida.'
        expect(page).to have_link 'Acesso candidatos'
        expect(page).not_to have_content candidate.email
        expect(page).not_to have_content 'Login efetuado com sucesso'
    end

    scenario 'and with the right email and password' do
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312', bio: 'candidata',
                                      email: 'maria@email.com.br', password: '234567')

        visit root_path
        click_on 'Acesso candidatos'
        within('form') do
            fill_in 'E-mail', with: 'mariana@email.com.br'
            fill_in 'Senha', with: '294567'
            click_on 'Entrar'
        end

        expect(page).to have_content 'E-mail ou senha inválidos.'
        expect(page).to have_link 'Acesso candidatos'
        expect(page).not_to have_content candidate.email
        expect(page).not_to have_content 'Login efetuado com sucesso'
    end
end
