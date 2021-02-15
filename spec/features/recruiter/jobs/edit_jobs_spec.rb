require 'rails_helper'

feature 'Recruiter edits company job openings' do
    background do
      company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                social: 'twitter.com/campuscode')
      recruiter = Recruiter.create!(email: 'dev@campuscode.com.br', password: '654321')
      job = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de 
                                aplicações web', pay: 2500, level: 'Júnior', prerequisite: 'Ruby on Rails',
                                expiration_date: '06/09/2021', number_of_openings: 4, company: company)

      login_as recruiter, scope: :recruiter
    end

    scenario 'From home page' do
        visit root_url
        click_on 'Entrar'
        click_on 'Vagas publicadas'
        click_on 'Desenvolvedor(a) Web'

        expect(current_path).to eq(job_path(Job.last)) 
        expect(page).to have_link('Editar vaga')
    end

    scenario 'Successfully' do
      visit root_url
      click_on 'Entrar'
      click_on 'Vagas publicadas'
      click_on 'Desenvolvedor(a) Web'
      click_on 'Editar vaga'
      within ('form') do
        fill_in 'Título', with: 'DevOps'
        fill_in 'Descrição', with: 'Engenheiro DevOps'
        fill_in 'Faixa Salarial', with: 3000
        click_on 'Salvar alterações'
      end

      expect(page).to have_content('Vaga editada com sucesso.')
      expect(page).to have_content('Engenheiro DevOps')
      expect(page).to have_content('R$ 3.000,00')
      expect(page).to have_link('Voltar')
      expect(page).not_to have_content('Desenvolvedor(a) Mobile')
    end

    scenario 'And can not be a job from another company' do
        other_company = Company.create!(name: 'TreinaDev', address: 'Alameda Santos, 1293',
        cnpj: '11.555.333/0000-94', website: 'treinadev.com.br',
        social: 'twitter.com/treinadev')
        job = Job.create!(title: 'Tech Lead', description: 'Liderança', pay: 5000, 
                         level: 'Sênior', prerequisite: 'Anos de experiência',
                         expiration_date: '06/09/2021', number_of_openings: 4, 
                         company: other_company)

        visit root_url
        click_on 'Vagas'
        click_on 'Tech Lead'

        expect(page).not_to have_link('Editar vaga')
    end
end