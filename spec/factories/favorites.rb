FactoryGirl.define do

  factory :favorite do
    association :show, :factory => :show
    association :user, :factory => :user
  end

end