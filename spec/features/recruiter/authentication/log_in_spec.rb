require 'rails_helper'

feature 'Recruiter log in the platform' do
    scenario 'successfully' do
        recruiter = Recruiter.create!(email: 'rh@treinadev.com.br', password: 'tr4b4lh0')

        visit root_path
        click_on 'Entrar'
        within('form') do
            fill_in 'E-mail', with: recruiter.email
            fill_in 'Senha', with: recruiter.password
            click_on 'Entrar'
        end

        expect(page).to have_content recruiter.email
        expect(page).to have_content 'Login efetuado com sucesso'
        expect(page).to have_link 'Sair'
        expect(page).not_to have_link 'Entrar'
    end

    scenario 'and must fill all fields' do
        recruiter = Recruiter.create!(email: 'rh@treinadev.com.br', password: 'tr4b4lh0')

        visit root_path
        click_on 'Entrar'
        within('form') do
            fill_in 'E-mail', with: ''
            fill_in 'Senha', with: ''
            click_on 'Entrar'
        end

        expect(page).to have_content 'E-mail ou senha inválida.'
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_content recruiter.email
        expect(page).not_to have_content 'Login efetuado com sucesso'
    end

    scenario 'and with the right email and password' do
        recruiter = Recruiter.create!(email: 'rh@treinadev.com.br', password: 'tr4b4lh0')

        visit root_path
        click_on 'Entrar'
        within('form') do
            fill_in 'E-mail', with: 'dev@treinadev.com.br'
            fill_in 'Senha', with: '123456'
            click_on 'Entrar'
        end

        expect(page).to have_content 'E-mail ou senha inválidos.'
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_content recruiter.email
        expect(page).not_to have_content 'Login efetuado com sucesso'
    end
end