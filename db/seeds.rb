# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Patient.destroy_all
Clinic.destroy_all
PainScore.destroy_all
Procedure.destroy_all
TeamMember.destroy_all

patients_array = []
50.times do
  doctor = Faker::Name.prefix + " " + Faker::Name.first_name + " " + Faker::Name.last_name

  num = rand(1..10)
  if num % 2 == 0
    program_stat = "Active"
  else
    program_stat = "Complete"
  end
  if num % 2 == 0
    response_stat = "No Response"
  else
    response_stat = "Follow up required"
  end

  numArray = []
  10.times do |i|
    numArray.push(rand(0..9))
  end


  mobile = numArray.join('')


  create = Patient.create!(
    consent: Faker::Boolean.boolean,
    first_name: Faker::Name.first_name,
    referring_clinician: doctor,
    last_name: Faker::Name.last_name,
    mobile_number: mobile,
    procedure_start_date: Faker::Date.backward(days: rand(1..30)),
    program_status: program_stat,
    response_status: response_stat,
    return_patient: Faker::Boolean.boolean,
    status: "Active"
  )

  patients_array.push create
end

clinic_array = []
3.times do
  address = Faker::Address.street_address + ", " + Faker::Address.city + ", " + Faker::Address.city + ", " + Faker::Address.state + ", " + Faker::Address.postcode

  create = Clinic.create!(
    address: address,
    name: Faker::Company.name,
    status: "Active"
  )
  clinic_array.push create
end

pain_scores_array = []
300.times do |i|
  day_score = 0
  if i <= 50
    day_score = 0
  elsif i > 50 && i <= 100
    day_score = 1
  elsif i > 100 && i <= 150
    day_score = 3
  elsif i > 150 && i <= 200
    day_score = 7
  elsif i > 200 && i <= 250
    day_score = 14
  elsif i > 250
    day_score = 28
  end

  create = PainScore.create(
    day: day_score,
    score: rand(1..10),
  )

  pain_scores_array.push create
end

procedure_array = []
mobile_string = Faker::PhoneNumber.cell_phone.to_s

mobile_number = []
mobile_string.split("").each do |char|
  if char.to_i >= 0 && char.to_i <= 9
    mobile_number.push char
  end
end
mobile_number = mobile_number.join("").to_s


d = DateTime.parse(Faker::Date.forward(days: rand(1..30)).to_s)

date = d.strftime("%Y-%m-%d")

first_three = []
second_three = []
last_four = []
count = 1

mobile_number.to_s.split("").each do |char|
  if count >= 1 && count <= 3
    first_three.push char
  elsif count > 3 && count <= 6
    second_three.push char
  else
    last_four.push char
  end
  count += 1
end

number = "(" + first_three.join("").to_s + ") " + second_three.join("").to_s + " " + last_four.join("").to_s

procedure_id = date + "_" + number

50.times do |i|
  puts Faker::PhoneNumber.cell_phone.match(/[0-9]{10}/)

  if Faker::PhoneNumber.cell_phone.match(/[0-9]{10}/)
    mobile_number = Faker::PhoneNumber.cell_phone.match(/[0-9]{10}/).to_s
  else
    mobile_number = "0450123123"
  end

  d = DateTime.parse(Faker::Date.forward(days: rand(1..30)).to_s)

  date = d.strftime("%Y-%m-%d")

  first_three = []
  second_three = []
  last_four = []

  count = 1
  mobile_number.to_s.split("").each do |char|
    if count >= 1 && count <= 3
      first_three.push char
    elsif count > 3 && count <= 6
      second_three.push char
    else
      last_four.push char
    end
    count += 1
  end

  number = "(" + first_three.join("").to_s + ") " + second_three.join("").to_s + " " + last_four.join("").to_s

  procedure_id = date + "_" + number

  create = Procedure.create!(
    description: Faker::Lorem.paragraph,
    name: Faker::Lorem.sentence(word_count: 3),
    procedure_ID: procedure_id
  )
  procedure_array.push create
end

team_members_array = []
users = ["1618362030191x468853074473446000","1618441281287x713086912311100500","1620094895768x157513755309299330","1620189400355x126390882319669330","1620189525375x692088174123178100","1620189700608x107645580839518030","1620189983577x101508744620877340","1620190170096x291132634976257300","1620190232695x460110950679898200"]
first_names = [
  "Network",
  "Admin",
  "Contributor"
]
9.times do |i|

  email = Faker::Name.first_name + "@" + Faker::Name.last_name + ".com"

  if i < 3
    create = TeamMember.create!(
      email: first_names[i].downcase + "@user.com",
      first_name: first_names[i],
      last_name: "User",
      user: users[i],
      status: "Active",
      role: first_names[i],
      password: "chicken"
    )
  else
    create = TeamMember.create!(
      email: email,
      first_name: Faker::Name.first_name ,
      last_name: Faker::Name.last_name ,
      user: users[i],
      status: "Active",
      role: "Contributor",
      password: "chicken"
    )
  end
  team_members_array.push create
end

#Clinincs >-< Patients Associations
50.times do |i|
  if i <= 16
    clinic_array[0].patients << patients_array[i]
  elsif i > 16 && i <= 32
    clinic_array[1].patients << patients_array[i]
  elsif i > 32
    clinic_array[2].patients << patients_array[i]
  end
end
puts "------------------------------------------"
puts "Testing clinics >-< patients associations:"
puts "The clinic '#{ Clinic.first.name }' has patients #{Clinic.first.patients.pluck(:first_name).join(',')}"
puts "The patient #{ Patient.last.first_name } has clinics: #{ Patient.last.clinics.pluck(:name).join(', ') }"
puts "------------------------------------------"
#Patients -< PainScore Associations
counter = 0
6.times do |i|
  50.times do |j|
      patients_array[j].pain_scores << pain_scores_array[counter]
      counter += 1
  end
end
puts "------------------------------------------"
puts "Testing patients -< pain scores associations:"
puts "The patient '#{ Patient.first.first_name }' has pain score #{Patient.first.pain_scores.first.score}"
puts "The pain score '#{ PainScore.last.score }' has patient #{PainScore.last.patient.first_name}"
puts "------------------------------------------"
#Patients -< Procedure Associations
50.times do |i|
  # puts "procedure: " + procedure_array[i].id.to_s
  # puts "patients: " + patients_array[i].id.to_s
  patients_array[i].procedures << procedure_array[i]
end
puts "------------------------------------------"
puts "Testing patients -< procedures associations:"
puts "The patient '#{ Patient.first.first_name }' has procedure #{Patient.first.procedures.name}"
puts "The procedure '#{ Procedure.last.name }' has patient #{Procedure.last.patient.first_name}"
puts "------------------------------------------"
#Patients >- team_members Associations
counter = 0
9.times do |i|
  50.times do |j|
      team_members_array[i].patients << patients_array[j]
      counter += 1
  end
end
puts "------------------------------------------"
puts "Testing patients -< team members associations:"
puts "The patient '#{ Patient.first.first_name }' has team member #{Patient.first.team_member.first_name}"
puts "The team member #{ TeamMember.last.first_name } has patient: #{ TeamMember.last.patients.pluck(:first_name).join(', ') }"
puts "------------------------------------------"
#Procedure >- pain_scores Associations
counter = 0
50.times do |i|
  6.times do |j|
    procedure_array[i].pain_scores << pain_scores_array[counter]
    counter += 1
  end
end
puts "------------------------------------------"
puts "Testing procedure -< pain_scores associations:"
puts "The pain score '#{ PainScore.first.score }' has procedure #{PainScore.first.procedure.name}"
puts "The procedure #{ Procedure.last.name } has pain score: #{ Procedure.last.pain_scores.pluck(:score).join(', ') }"
puts "------------------------------------------"
#Procedure >- clinic Associations
counter = 0
50.times do |i|
  if i <= 16
    clinic_array[0].procedures << procedure_array[i]
  elsif i > 16 && i <= 32
    clinic_array[1].procedures << procedure_array[i]
  elsif i > 32
    clinic_array[2].procedures << procedure_array[i]
  end
end
puts "------------------------------------------"
puts "Testing procedure >- clinics associations:"
puts "The Procedure '#{ Procedure.first.name }' has clinic #{Procedure.first.clinic.name}"
puts "The clinic #{ Clinic.last.name } has procedures: #{ Clinic.last.procedures.pluck(:name).join(', ') }"
puts "------------------------------------------"
#team_members >- clinic Associations
counter = 0
9.times do |i|
  if i <= 16
    clinic_array[0].team_members << team_members_array[i]
  elsif i > 16 && i <= 32
    clinic_array[1].team_members << team_members_array[i]
  elsif i > 32
    clinic_array[2].team_members << team_members_array[i]
  end
end
puts "------------------------------------------"
puts "Testing team_members >-< clinic associations:"

puts "The team member #{ TeamMember.first.first_name } has clinics: #{ TeamMember.first.clinics.pluck(:name).join(', ') }"
puts "The clinic #{ Clinic.last.name } has team members: #{ Clinic.last.team_members.pluck(:first_name).join(', ') }"
puts "------------------------------------------"
