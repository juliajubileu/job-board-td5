# BALCÃO DE EMPREGOS
<p>
<img alt="Ruby" src="https://img.shields.io/badge/ruby-%23CC342D.svg?&style=for-the-badge&logo=ruby&logoColor=white"/>
<img alt="Rails" src="https://img.shields.io/badge/rails%20-%23CC0000.svg?&style=for-the-badge&logo=ruby-on-rails&logoColor=white"/>
<img alt="Bootstrap" src="https://img.shields.io/badge/bootstrap%20-%23563D7C.svg?&style=for-the-badge&logo=bootstrap&logoColor=white"/>
<img alt="SQLite" src ="https://img.shields.io/badge/sqlite-%2307405e.svg?&style=for-the-badge&logo=sqlite&logoColor=white"/>
</p>

> Plataforma de divulgação de vagas de emprego em tecnologia.  

## Descrição

Realizado como projeto final do [TreinaDev](https://www.treinadev.com.br/home), consiste na criação de uma plataforma Web que permite que recrutadores de empresas de tecnologia divulguem vagas de empregos e gerenciem o processo de contratação de novos talentos. Além disso, a plataforma funcionará como um site de busca de oportunidades para os visitantes. Um visitante pode conhecer empresas, ver suas vagas disponíveis e aplicar para estas vagas.

## Funcionalidades

- [x] Colaborador cria conta usando e-mail da empresa
- [x] Colaborador preenche dados da empresa, caso seja a primeira pessoa da empresa a se cadastrar
- [x] Colaborador cadastra uma nova vaga de emprego
- [x] Visitante navega pelo site e vê as empresas cadastradas
- [x] Visitante decide se inscrever para uma vaga
- [x] Visitante cria sua conta e preenche um perfil para confirmar sua candidatura
- [x] Colaborador da empresa visualiza as candidaturas recebidas
- [ ] Colaborador da empresa faz uma proposta para um candidato
- [ ] Candidato (agora autenticado) visualiza as propostas recebidas
- [ ] Colaborador ou candidato podem aceitar/reprovar uma candidatura

## Gems utilizadas

* [Devise](https://github.com/heartcombo/devise)
* [Rspec](https://github.com/rspec/rspec-rails)
* [Capybara](https://github.com/teamcapybara/capybara)
* [SimpleCov](https://github.com/simplecov-ruby/simplecov)
* [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)

## Como executar o projeto

Para executar esse projeto, você deve instalar e configurar a linguagem Ruby versão 2.7.2 e o framework Rails versão 6.1.2 em seu computador. Em seguida, siga os passos abaixo: 

Clone este repositório

```cmd
git clone https://github.com/JuliaJubileu/job-board-td5
```

Abra o diretório pelo terminal

```bash
cd  job-board-td5
```

Instale as gems rodando o comando Bundle install

```bash
bundle install
```

Gere o banco de dados 

```bash
rails db:create
```
```bash
rails db:migrate
```

### Rodando os testes

Para executar os testes, rode o seguinte comando no terminal

```bash
rspec 
```

### Rodando no navegador

Para executar a aplicação em seu navegador, rode o seguinte comando no terminal

```bash
rails server
```

Em seguida abra seu navegador e digite `localhost:3000`


## Status
Projeto em desenvolvimento. Mais detalhes sobre o processo [aqui](https://www.notion.so/Projeto-2-Balc-o-de-Empregos-4dbe791ce3224d80bb1bf56ca07e23a0)! :blush:	
