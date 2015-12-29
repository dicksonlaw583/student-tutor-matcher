# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    body	"Test message"
    subject	"Test subject"
    read 	false
  end
end
