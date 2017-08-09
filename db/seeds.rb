# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ['president', 'hr', 'team_leader', 'employee'].each do |role|
role_president = Role.find_or_create_by(role: "president")
role_hr = Role.find_or_create_by(role: "hr")
role_team_leader = Role.find_or_create_by(role: "team_leader")
role_employee = Role.find_or_create_by(role: "employee")

president = Employee.create(email: "president@abc.com", password: "password", role_id: role_president.id)
hr = Employee.create(email: "hr@abc.com", password: "password", role_id: role_hr.id)
# team_leader = User.create(email: "team_leader@abc.com", password: "password", role_id: role_student.id)
# employee = User.create(email: "employee@qmployee.com", password: "password", role_id: role_student.id)
