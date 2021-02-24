require 'rails_helper'

feature 'Recruiter register a job opening' do
    scenario 'from home page' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  domain: 'campuscode.com.br')
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456', 
                                      company: company)


        login_as recruiter, scope: :recruiter
        visit root_url
        click_on recruiter.email

        expect(current_path).to eq(recruiters_path)
        expect(page).to have_content('Painel do recrutador - Campus Code')
        expect(page).to have_link('Publicar vaga')
    end
    scenario 'successfully' do 
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  domain: 'campuscode.com.br')
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456', 
                                      company: company)

        login_as recruiter, scope: :recruiter
        visit root_url
        click_on recruiter.email
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: 'Desenvolvedor(a) Web'
            fill_in 'Descrição', with: 'Buscamos uma pessoa experiente que 
                                                 colabore e contribua no desenvolvimento 
                                                 e na evolução contínua do nosso produto, 
                                                 sendo uma referência no time.'
            fill_in 'Requisitos obrigatórios', with: 'Domínio da linguagem Ruby e do framework 
                                               Ruby on Rails; Experiência com desenvolvimento, 
                                               testes e documentação de APIs REST; Vivência em 
                                               metodologias ágeis'
            fill_in 'Nível do cargo', with: 'Pleno'
            fill_in 'Oferta de remuneração', with: 2500
            fill_in 'Vagas disponíveis', with: 3
            fill_in 'Data limite para envio de candidaturas', with: '25/05/2021'
            click_on 'Salvar'
        end

        expect(page).to have_content('Vaga publicada com sucesso')
        expect(page).to have_content('Desenvolvedor(a) Web')
        expect(page).to have_content('R$ 2.500,00')
        expect(page).to have_content('Pleno')
        expect(page).to have_link('Editar vaga')
        expect(page).to have_link('Desativar vaga')
    end

    scenario 'and must fill all required fields' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  domain: 'campuscode.com.br')
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456', 
                                      company: company)

        login_as recruiter, scope: :recruiter
        visit root_url
        click_on recruiter.email
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: ''
            fill_in 'Descrição', with: ''
            fill_in 'Requisitos obrigatórios', with: ''
            fill_in 'Nível do cargo', with: ''
            fill_in 'Oferta de remuneração', with: ''
            fill_in 'Vagas disponíveis', with: ''
            fill_in 'Data limite para envio de candidaturas', with: ''
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível criar a vaga')
        expect(page).to have_content('Título não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Requisitos obrigatórios não pode ficar em branco')
        expect(page).to have_content('Nível não pode ficar em branco')
        expect(page).to have_content('Oferta de remuneração não pode ficar em branco')
        expect(page).to have_content('Vagas disponíveis não pode ficar em branco')
        expect(page).to have_content('Data limite não pode ficar em branco')
        expect(page).not_to have_link('Editar vaga')
        expect(page).not_to have_link('Desativar vaga')
    end

    scenario 'and remuneration must be higher than minimum wage' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  domain: 'campuscode.com.br')
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456', 
                                      company: company)

        login_as recruiter, scope: :recruiter
        visit root_url
        click_on recruiter.email
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: 'Desenvolvedor(a) Web'
            fill_in 'Descrição', with: 'Buscamos uma pessoa experiente que 
                                                 colabore e contribua no desenvolvimento 
                                                 e na evolução contínua do nosso produto, 
                                                 sendo uma referência no time.'
            fill_in 'Requisitos obrigatórios', with: 'Domínio da linguagem Ruby e do framework 
                                               Ruby on Rails; Experiência com desenvolvimento, 
                                               testes e documentação de APIs REST; Vivência em 
                                               metodologias ágeis'
            fill_in 'Nível do cargo', with: 'Pleno'
            fill_in 'Oferta de remuneração', with: 1000
            fill_in 'Vagas disponíveis', with: 3
            fill_in 'Data limite para envio de candidaturas', with: '25/05/2021'
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível criar a vaga')
        expect(page).to have_content('Oferta de remuneração deve ser maior que salário mínimo (R$1.100,00)')
        expect(page).not_to have_link('Editar vaga')
        expect(page).not_to have_link('Desativar vaga')
    end

    scenario 'and closing date must be in the future' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  domain: 'campuscode.com.br')
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456', 
                                      company: company)

        login_as recruiter, scope: :recruiter
        visit root_url
        click_on recruiter.email
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: 'Desenvolvedor(a) Web'
            fill_in 'Descrição', with: 'Buscamos uma pessoa experiente que 
                                                 colabore e contribua no desenvolvimento 
                                                 e na evolução contínua do nosso produto, 
                                                 sendo uma referência no time.'
            fill_in 'Requisitos obrigatórios', with: 'Domínio da linguagem Ruby e do framework 
                                               Ruby on Rails; Experiência com desenvolvimento, 
                                               testes e documentação de APIs REST; Vivência em 
                                               metodologias ágeis'
            fill_in 'Nível do cargo', with: 'Pleno'
            fill_in 'Oferta de remuneração', with: 2500
            fill_in 'Vagas disponíveis', with: 3
            fill_in 'Data limite para envio de candidaturas', with: '25/05/2020'
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível criar a vaga')
        expect(page).to have_content('Data limite deve ser futura')
        expect(page).not_to have_link('Editar vaga')
        expect(page).not_to have_link('Desativar vaga')
    end

    scenario 'and total openings must be positive integer' do
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'campuscode.com.br',
                                  domain: 'campuscode.com.br')
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456', 
                                      company: company)

        login_as recruiter, scope: :recruiter
        visit root_url
        click_on recruiter.email
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: 'Desenvolvedor(a) Web'
            fill_in 'Descrição', with: 'Buscamos uma pessoa experiente que 
                                                 colabore e contribua no desenvolvimento 
                                                 e na evolução contínua do nosso produto, 
                                                 sendo uma referência no time.'
            fill_in 'Requisitos obrigatórios', with: 'Domínio da linguagem Ruby e do framework 
                                               Ruby on Rails; Experiência com desenvolvimento, 
                                               testes e documentação de APIs REST; Vivência em 
                                               metodologias ágeis'
            fill_in 'Nível do cargo', with: 'Pleno'
            fill_in 'Oferta de remuneração', with: 2500
            fill_in 'Vagas disponíveis', with: 0.2
            fill_in 'Data limite para envio de candidaturas', with: '25/05/2021'
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível criar a vaga')
        expect(page).to have_content('Vagas disponíveis deve ser número positivo')
        expect(page).not_to have_link('Editar vaga')
        expect(page).not_to have_link('Desativar vaga')
    end
end