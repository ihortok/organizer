user = User.find_or_initialize_by(username: 'superuser')

unless user.id
  user.email = 'user@mail.com'
  user.password = 'strongPassword_123'

  user.save!
end

unless user.tasks.any?
  tasks = [
    { title: Faker::Hipster.sentence, user: user },
    { title: Faker::Hipster.sentence, user: user }
  ]

  tasks.each do |t|
    Task.create(t)
  end
end
