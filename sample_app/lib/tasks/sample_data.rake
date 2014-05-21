=begin

This defines a task db:populate that creates an example user with name and email address 
replicating our previous one, and then makes 99 more.

=end

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do # ensures that the Rake task has access to the local Rails environment
   
    make_users
    make_microposts
    make_relationships 
  end
end








def make_users
  # Here create! is just like the create method, except it raises an exception 
  # for an invalid user rather than returning false. This noisier construction 
  # makes debugging easier by avoiding silent errors.
  admin = User.create!(name: "Mohammed Alnakli",
               email: "hah_m14@yahoo.com",
               password: "123456",
               password_confirmation: "123456",
               admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end

end

def make_microposts
  users = User.limit(6)
      50.times do
        content = Faker::Lorem.sentence(5)
        users.each { |user| user.microposts.create!(content: content) }
      end
end
def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50] # users_id from 2 to 50
  followers      = users[3..40] # users_id from 3 to 40
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end
