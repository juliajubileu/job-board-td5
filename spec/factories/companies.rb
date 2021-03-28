FactoryBot.define do
  factory :company do
    name { 'Campus Code' }
    address { 'Alameda Santos, 1293' }
    cnpj { '11.222.333/0000-44' }
    website { 'www.campuscode.com.br' }
    domain { 'campuscode.com.br' }
  end
end
