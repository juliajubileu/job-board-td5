FactoryBot.define do
  factory :job do
    title { 'Desenvolvedor(a) Web' }
    description { 'Desenvolvimento de aplicações web' }
    remuneration { 2500 }
    level { 'Júnior' }
    requirements { 'Ruby on Rails' }
    expiration_date { '06/09/2021' }
    spots_available { 4 }
  end
end
