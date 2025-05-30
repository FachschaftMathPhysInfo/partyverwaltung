# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Councils
council = Council.create!(name: "Main Council", shortcut: "MC", color: "#FF0000")

# People
person1 = Person.create!(vname: "Alice", nname: "Anderson", mail: "alice@example.com", shirt: "M", typ: "member", wert: 10)
person2 = Person.create!(vname: "Bob", nname: "Brown", mail: "bob@example.com", shirt: "L", typ: "admin", wert: 20)

# Parties
party = Party.create!(jahr: 2024, semester: "SS", active: true)

# Notes
Note.create!(wertung: 1, text: "Great job!", person_id: person1.id, party_id: party.id, author: "System")
Note.create!(wertung: 2, text: "Needs improvement.", person_id: person2.id, party_id: party.id, author: "System")

# Judges
Judge.create!(controller: "events", method: "approve", level: 1)
Judge.create!(controller: "users", method: "ban", level: 2)

# Rights
Right.create!(nick: "alice", level: 1)
Right.create!(nick: "bob", level: 2)

# Statuses
Status.create!(person_id: person1.id, value: 1)
Status.create!(person_id: person2.id, value: 2)

# Shirts
Shirt.create!(jahr: 2024, semester: "SS", motto: "Summer Vibes", photo_file_name: "shirt1.png", photo_content_type: "image/png", photo_file_size: 12345, photo_updated_at: Time.now)

# Sections
section = Section.create!(name: "Logistics", text: "Handles logistics", visible: true, party_id: party.id)

# Section Managers
SectionManager.create!(section_id: section.id, person_id: person1.id)

# Shifts
Shift.create!(start: "09:00", ende: "12:00", party_id: party.id, section_id: section.id, council_id: council.id)

# Logs
Log.create!(controller: "sessions", method: "login", user: "alice")

# Emails
Email.create!(name: "Welcome", subject: "Welcome to the Party!", content: "Hello and welcome!", sendcode: "welcome")

puts "Seeded example data."
