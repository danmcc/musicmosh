FactoryGirl.define do

  factory :show do
    association :artist, :factory => :artist
    association :venue, :factory => :venue
  end

end