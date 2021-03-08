# EMPRESAS

tech_lab = Company.create!(name: 'Tech Lab', address: 'Rua A, 123', cnpj: '11.555.333/0000-44',
                           website: 'www.techlab.com.br', domain: 'techlab.com.br')
db_dot = Company.create!(name: 'DB Dot', address: 'Rua B, 321', cnpj: '11.777.333/0000-44', 
                          website: 'www.dbdot.com', domain: 'dbdot.com')
thought_dock = Company.create!(name: 'Thought Dock', address: 'Rua C, 456', cnpj: '11.654.333/0000-44', 
                           website: 'www.thoughtdock.com.br', domain: 'thoughtdock.com.br')
goodbank = Company.create!(name: 'Goodbank', address: 'Rua Bank, 3', cnpj: '54.555.333/0000-44', 
                           website: 'www.gbank.com.br', domain: 'gbank.com.br')
ruby_corp = Company.create!(name: 'Ruby Corporation', address: 'Rua Ruby, 123', cnpj: '11.555.765/0000-44', 
                           website: 'www.rubycorp.com', domain: 'rubycorp.com')
dev_works = Company.create!(name: 'Dev Works', address: 'Rua Dev, 453', cnpj: '56.555.336/0000-44', 
                           website: 'www.devworks.tech', domain: 'devworks.tech')

# VAGAS

web_dev = Job.create!(title: 'Desenvolvedor(a) Web', description: 'Desenvolvimento de aplicações web', 
                      remuneration: 3000, level: 'Júnior', requirements: 'Ruby on Rails',
                      expiration_date: '06/09/2021', spots_available: 2, company: tech_lab, status: :enabled)
mobile_dev = Job.create!(title: 'Desenvolvedor(a) Mobile', description: 'Desenvolvimento de aplicações mobile', 
                         remuneration: 2500, level: 'Júnior', requirements: 'Flutter',
                         expiration_date: '03/04/2021', spots_available: 2, company: tech_lab, status: :enabled)
software_engineer = Job.create!(title: 'Engenheiro(a) de Software', description: 'Você usará seu conhecimento 
                               técnico e habilidades especializadas para apoiar, construir, implementar e melhorar
                               as soluções de tecnologia.', remuneration: 5000, level: 'Pleno', requirements: 'Ruby, 
                               Elixir, Java ou Python;  Experiência com Devops, conhecimento em infraestrutura e automação; 
                               Habilidade para escrever código otimizado e de acordo com as boas práticas de desenvolvimento.',
                               expiration_date: '20/07/2021', spots_available: 3, company: goodbank, status: :enabled)
programmer = Job.create!(title: 'Programador(a) Fullstack', description: 'Desenvolver programas conforme escopo e especificações
                        definidas pelas áreas de negócio; Criação de telas para interface com usuário; Apoiar a implantação do 
                        processo definido; Monitorar continuamente os processos desenvolvidos; Entender e atender as expectativas 
                        do cliente no que diz respeito às funcionalidades do software', remuneration: 6000, 
                        level: 'Pleno', requirements: 'Experiência em desenvolvimento de sistemas; Ter Vivência como programador
                        em algumas destas linguagens( PHP / .Net, C#, entre outras, banco de dados SQL Server). ',
                        expiration_date: '15/06/2021', spots_available: 2, company: dev_works, status: :enabled)
ror_developer = Job.create!(title: 'Desenvolvedor(a) Ruby on Rails', description: 'Você trabalhará com nossos clientes 
                            para criar ótimos produtos que encantem os usuários.', remuneration: 4000, level: 'Pleno', 
                            requirements: 'Os candidatos bem qualificados terão um excelente conhecimento de HTML, CSS,
                            JavaScript, refatoração, padrões de design e outras práticas de programação.', expiration_date: '06/09/2021',
                            spots_available: 2, company: ruby_corp, status: :enabled)
product_designer = Job.create!(title: 'Designer de Produto', description: 'Você irá colaborar com desenvolvedores e clientes
                              para transformar ideias em excelentes produtos que as pessoas adoram usar e ajudar a desenvolver
                              negócios de sucesso.', remuneration: 5500, level: 'Pleno', requirements: 'Você comunica os fluxos,
                              interação e movimento do usuário e sabe qual ferramenta usar, dependendo do escopo e da fase do 
                              projeto. Você procura novas ferramentas, experimenta-as e avalia se a equipe mais ampla deve usá-las.',
                              expiration_date: '06/05/2021', spots_available: 1, company: thought_dock, status: :enabled)

# RECRUTADORES

second_recruiter = Recruiter.create!(email: 'rh@techlab.com.br', password: '123456', company: tech_lab)
first_recruiter = Recruiter.create!(email: 'rh@gbank.com.br', password: '123456', company: goodbank)
third_recruiter = Recruiter.create!(email: 'rh@dbdot.com.br', password: '123456', company: db_dot)

# CANDIDATOS

maria = Candidate.create!(full_name: 'Maria Oliveira', cpf: '123.321.123-12',  bio: 'candidata',
                          email: 'maria@email.com.br', password: '654321')
ana = Candidate.create!(full_name: 'Ana Lourenço', cpf: '123.456.789-10',  bio: 'candidata',
                        email: 'ana@email.com.br', password: '654321')
carol = Candidate.create!(full_name: 'Carol Fernandes', cpf: '987.654.321-00',  bio: 'candidata',
                          email: 'carol@email.com.br', password: '654321')


# APLICAÇÕES

maria_apply = JobApplication.create!(job: mobile_dev, candidate: maria, status: :pending)
ana_apply = JobApplication.create!(job: ror_developer, candidate: ana, status: :approved)
carol_apply = JobApplication.create!(job: programmer, candidate: carol, status: :pending)
carol_other_apply = JobApplication.create!(job: software_engineer, candidate: carol, status: :rejected)

# OFERTAS

offer_to_ana = Offer.create!(message: 'Parabéns', salary: 4000, starting_date: '05/04/2021', 
                             job_application: ana_apply, status: :pending)
