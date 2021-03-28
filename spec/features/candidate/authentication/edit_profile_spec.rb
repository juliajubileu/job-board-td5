require 'rails_helper'

feature 'Candidate edits profile' do
  scenario 'successfully' do
    # Arrange
    candidate = Candidate.create!(full_name: 'Maria Oliveira',
                                  cpf: '12312312312',
                                  email: 'maria@email.com.br',
                                  password: '234567',
                                  bio: 'Candidata')

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on candidate.email
    click_on 'Editar perfil'
    within('form') do
      fill_in 'Nome completo', with: 'Maria da Silva'
      fill_in 'Nome social', with: 'Maria'
      fill_in 'Nova senha', with: '123456'
      fill_in 'Confirme a senha', with: '123456'
      fill_in 'Senha atual', with: '234567'
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Sua conta foi atualizada com sucesso')
    expect(page).to have_content('maria@email.com')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Acesso candidatos')
    expect(page).not_to have_link('Acesso recrutadores')
  end

  scenario 'and current password can not be blank' do
    # Arrange
    candidate = Candidate.create!(full_name: 'Maria Oliveira',
                                  cpf: '12312312312',
                                  email: 'maria@email.com.br',
                                  password: '234567', bio: 'Candidata')

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on candidate.email
    click_on 'Editar perfil'
    within('form') do
      fill_in 'Nome completo', with: 'Maria da Silva'
      fill_in 'Nome social', with: 'Maria'
      fill_in 'Nova senha', with: ''
      fill_in 'Confirme a senha', with: ''
      fill_in 'Senha atual', with: ''
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível salvar candidato')
    expect(page).to have_content('Senha atual não pode ficar em branco')
  end

  scenario 'and new password must match confirmation' do
    # Arrange
    candidate = Candidate.create!(full_name: 'Maria Oliveira',
                                  cpf: '12312312312',
                                  email: 'maria@email.com.br',
                                  password: '234567', bio: 'Candidata')

    # Act
    login_as candidate, scope: :candidate
    visit root_url
    click_on candidate.email
    click_on 'Editar perfil'
    within('form') do
      fill_in 'Nome completo', with: 'Maria da Silva'
      fill_in 'Nome social', with: 'Maria'
      fill_in 'Nova senha', with: '123456'
      fill_in 'Confirme a senha', with: '654321'
      fill_in 'Senha atual', with: '234567'
      click_on 'Salvar'
    end

    # Assert
    expect(page).to have_content('Não foi possível salvar candidato')
    expect(page).to have_content('Confirmação de senha não é igual a Senha')
  end
end
