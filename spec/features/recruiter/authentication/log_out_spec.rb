require 'rails_helper'

feature 'Recruiter log out of platform' do
    scenario 'successfully' do
        recruiter = Recruiter.create!(email: 'rh@treinadev.com.br', password: 'tr4b4lh0')

        visit root_path
        click_on 'Entrar'
        within('form') do
            fill_in 'E-mail', with: recruiter.email
            fill_in 'Senha', with: recruiter.password
            click_on 'Entrar'
        end
        click_on 'Sair'

        expect(page).to have_link 'Entrar'
        expect(page).not_to have_content recruiter.email
        expect(page).not_to have_link 'Sair'
    end
end