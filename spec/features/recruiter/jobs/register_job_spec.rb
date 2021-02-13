require 'rails_helper'

feature 'Recruiter register a job opening' do
    background do
        recruiter = Recruiter.create!(email: 'rh@campuscode.com.br', password: '123456')
        company = Company.create!(name: 'Campus Code', address: 'Alameda Santos, 1293',
        cnpj: 11222333000044, website: 'campuscode.com.br',
        social: 'twitter.com/campuscode', admin: recruiter)

        login_as recruiter, scope: :recruiter
    end

    scenario 'successfully' do 
        visit root_url
        click_on 'Entrar'
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: 'Desenvolvedor(a) Web'
            fill_in 'Descrição detalhada', with: 'Buscamos uma pessoa experiente que 
                                                 colabore e contribua no desenvolvimento 
                                                 e na evolução contínua do nosso produto, 
                                                 sendo uma referência no time.'
            fill_in 'Faixa Salarial', with: 2500
            check 'Júnior'
            fill_in 'Pré-requisitos', with: 'Domínio da linguagem Ruby e do framework 
                                             Ruby on Rails; Experiência com desenvolvimento, 
                                             testes e documentação de APIs REST; Vivência em 
                                             metodologias ágeis'

            fill_in 'Data limite', with: 25/05/2021
            fill_in 'Vagas disponíveis', with: 3
            click_on 'Salvar'
        end

        expect(page).to have_content('Vaga publicada com sucesso')
        expect(page).to have_content('Desenvolvedor(a) Web')
        expect(page).to have_content('R$ 2.500,00')
        expect(page).to have_content('Nível: Júnior')
        expect(page).to have_link('Editar vaga')
        expect(page).to have_link('Desativar vaga')
    end

    scenario 'and must fill all required fields' do
        visit root_url
        click_on 'Entrar'
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: ''
            fill_in 'Descrição', with: ''
            fill_in 'Faixa Salarial', with: ''
            fill_in 'Pré-requisitos', with: ''
            fill_in 'Data limite', with: ''
            fill_in 'Vagas disponíveis', with: ''
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível publicar a vaga')
        expect(page).to have_content('Título não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Faixa salarial não pode ficar em branco')
        expect(page).to have_content('Pré-requisitos não pode ficar em branco')
        expect(page).to have_content('Data limite não pode ficar em branco')
        expect(page).to have_content('Vagas disponíveis não pode ficar em branco')
        expect(page).not_to have_link('Editar vaga')
        expect(page).not_to have_link('Desativar vaga')
    end

    scenario 'and salary must be higher than minimum wage' do
        visit root_url
        click_on 'Entrar'
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: 'Desenvolvedor(a) Web'
            fill_in 'Descrição detalhada', with: 'Buscamos uma pessoa experiente que 
                                                 colabore e contribua no desenvolvimento 
                                                 e na evolução contínua do nosso produto, 
                                                 sendo uma referência no time.'
            fill_in 'Faixa Salarial', with: 1000
            check 'Júnior'
            fill_in 'Pré-requisitos', with: 'Domínio da linguagem Ruby e do framework 
                                             Ruby on Rails; Experiência com desenvolvimento, 
                                             testes e documentação de APIs REST; Vivência em 
                                             metodologias ágeis'

            fill_in 'Data limite', with: 25/05/2021
            fill_in 'Vagas disponíveis', with: 3
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível publicar a vaga')
        expect(page).to have_content('Faixa salarial deve ser maior que salário mínimo (R$1.100,00)')
        expect(page).not_to have_link('Editar vaga')
        expect(page).not_to have_link('Desativar vaga')
    end

    scenario 'and closing date must be in the future' do
        visit root_url
        click_on 'Entrar'
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: 'Desenvolvedor(a) Web'
            fill_in 'Descrição detalhada', with: 'Buscamos uma pessoa experiente que 
                                                 colabore e contribua no desenvolvimento 
                                                 e na evolução contínua do nosso produto, 
                                                 sendo uma referência no time.'
            fill_in 'Faixa Salarial', with: 2500
            check 'Júnior'
            fill_in 'Pré-requisitos', with: 'Domínio da linguagem Ruby e do framework 
                                             Ruby on Rails; Experiência com desenvolvimento, 
                                             testes e documentação de APIs REST; Vivência em 
                                             metodologias ágeis'

            fill_in 'Data limite', with: 25/01/2021
            fill_in 'Vagas disponíveis', with: 3
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível publicar a vaga')
        expect(page).to have_content('Data limite deve ser futura')
        expect(page).not_to have_link('Editar vaga')
        expect(page).not_to have_link('Desativar vaga')
    end

    scenario 'and total openings must be positive integer' do
        visit root_url
        click_on 'Entrar'
        click_on 'Publicar vaga'
        within('form') do
            fill_in 'Título', with: 'Desenvolvedor(a) Web'
            fill_in 'Descrição detalhada', with: 'Buscamos uma pessoa experiente que 
                                                 colabore e contribua no desenvolvimento 
                                                 e na evolução contínua do nosso produto, 
                                                 sendo uma referência no time.'
            fill_in 'Faixa Salarial', with: 1000
            check 'Júnior'
            fill_in 'Pré-requisitos', with: 'Domínio da linguagem Ruby e do framework 
                                             Ruby on Rails; Experiência com desenvolvimento, 
                                             testes e documentação de APIs REST; Vivência em 
                                             metodologias ágeis'

            fill_in 'Data limite', with: 25/05/2021
            fill_in 'Vagas disponíveis', with: 0.3
            click_on 'Salvar'
        end

        expect(page).to have_content('Não foi possível publicar a vaga')
        expect(page).to have_content('Número de vagas disponíveis deve ser inteiro e positivo')
        expect(page).not_to have_link('Editar vaga')
        expect(page).not_to have_link('Desativar vaga')
    end
end