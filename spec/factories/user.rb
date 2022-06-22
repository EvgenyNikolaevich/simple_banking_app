FactoryBot.define do
  factory :user do
    login    { "unqiue#{rand(0..1000)}" }
    password { 'asdf' }
  end
end 