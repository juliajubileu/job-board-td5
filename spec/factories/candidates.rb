FactoryBot.define do
  factory :candidate do
    full_name { 'Maria Oliveira' }
    cpf { '12312312312' }
    email { 'maria@email.com' }
    password { '234567' }
    bio { 'Candidata' }
  end
end
