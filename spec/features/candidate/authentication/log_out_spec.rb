require 'rails_helper'

feature 'Candidate log out of platform' do
    scenario 'successfully' do
        candidate = Candidate.create!(full_name: 'Maria Oliveira', cpf: '12312312312', bio: 'candidata',
        email: 'maria@email.com.br', password: '234567')

        login_as candidate, scope: :candidate
        visit root_path
        click_on 'Sair'

        expect(page).to have_link 'Acesso candidatos'
        expect(page).to have_link 'Acesso recrutadores'
        expect(page).not_to have_content candidate.email
        expect(page).not_to have_link 'Sair'
    end
end