# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ['president', 'hr', 'team_leader', 'employee'].each do |role|
# role_president = Role.find_or_create_by(role: "president")
# role_hr = Role.find_or_create_by(role: "hr")
# role_team_manager = Role.find_or_create_by(role: "team_manager")
# role_team_leader = Role.find_or_create_by(role: "team_leader")
# role_employee = Role.find_or_create_by(role: "employee")

# president = Employee.create(email: "president@abc.com", password: "password", role_id: role_president.id)
# hr = Employee.create(email: "hr@abc.com", password: "password", role_id: role_hr.id)
# team_leader = User.create(email: "team_leader@abc.com", password: "password", role_id: role_student.id)
# employee = User.create(email: "employee@qmployee.com", password: "password", role_id: role_student.id)
# Menu.create([
# 	{name: 'Dashboard'},
# 	{name: 'Employees'},
# 	{name: 'Employee Benefits'},
# 	{name: 'Exams'},
# 	{name: 'Subject List'},
# 	{name: 'Add Exam'},
# 	{name: 'Exam List'},
# 	{name: 'Admin Result'},
# 	{name: 'Employee Result'},
# 	{name: 'Performance Review'},
# 	{name: 'Templates'},
# 	{name: 'Send Requests'},
# 	{name: 'Review Employee'},
# 	{name: 'Disclosures'},
# 	{name: 'Documents'},
# 	{name: 'E-Signatures'},
# 	{name: 'Projects'},
# 	{name: 'Project Tracker'},
# 	{name: 'My Project'},
# 	{name: 'My Team Projects'},
# 	{name: 'Add Project'},
# 	{name: 'Project List'},
# 	{name: 'Add Project Team'},
# 	{name: 'List Project Team'},
# 	{name: 'Org Team Chart'},
# 	{name: 'Exam Team'},
# 	{name: 'Add Team'},
# 	{name: 'Teams'},
# 	{name: 'Reports'},
# 	{name: 'Performance Review'},
# 	{name: 'Highest Score Teams'},
# 	{name: 'Passed Ratio'},
# 	{name: 'Employees With Exams'},
# 	{name: 'Issues'},
# 	{name: 'Add Issue'},
# 	{name: 'Ticket Status'},
# 	{name: 'DCD Issues'},
# 	{name: 'Issue List'},
# 	{name: 'Attandance'},
# 	{name: 'Attendance Logs'},
# 	{name: 'Switch day'},
# 	{name: 'Leave Requests'},
# 	{name: 'List Leave Requests'},
# 	{name: 'Apply Leave'},
# 	{name: 'Leave Available Hours'},
# 	{name: 'List Available Hours'},
# 	{name: 'Add Available Hours'},
# 	{name: 'Notifications'}
# ])
Menu.create([{name: 'List Employees'}])