# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

roles = Role.create([{ name: "Librarian", description: "Librarian", code: 'librarian' }, { name: "Student", description: "Student", code: 'student' }])

RequestStatus.create([
  {
    name: "Returned",
    description: "Returned",
    code: 'returned'
  },
  {
    name: "Borrowed",
    description: "Borrowed",
    code: 'borrowed'
  },
])

User.create(email: "luisvillalta@ejemplo.com", password: '123456', password_confirmation: '123456', role: roles.first, first_name: 'Luis', last_name: 'Villalta')