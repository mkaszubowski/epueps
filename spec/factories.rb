FactoryGirl.define do
  factory :subject do
    name          "Subject"
    image_name    "subject.jpg"
    description   "Lorem ipsum"
    popularity    0
  end

  factory :lesson do
    name          "Lesson"
    description   "Lorem ipsum"       
  end

  factory :video do
    name          "Lesson video"
    link          "https://www.youtube.com/watch?v=CkhlTW7rjLk"
  end

  factory :user do
    email         "foo@bar.com"
    password      "foobar123"
  end 
end