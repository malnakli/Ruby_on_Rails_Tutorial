=begin

This defines a task db:populate that creates an example user with name and email address 
replicating our previous one, and then makes 99 more.

=end

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do # ensures that the Rake task has access to the local Rails environment
   
    # Here create! is just like the create method, except it raises an exception 
    # for an invalid user rather than returning false. This noisier construction 
    # makes debugging easier by avoiding silent errors.
   
    User.create!(name: "Mohammed",
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
end