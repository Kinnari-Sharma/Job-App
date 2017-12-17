# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Kinnary Sharma",
						 email: "kinnari.sharma@aot.edu.in",
						 role: "admin",
						 password: "foobar",
						 password_confirmation: "foobar")

User.create!(name: "Alka Sharma",
						 email: "alka@railstutorial.org",
						 role: "recruiter",
						 password: "foobar",
						 password_confirmation: "foobar")

User.create!(name: "Vaibhav Sharma",
						 email: "vsharma@railstutorial.org",
						 role: "job-seeker",
						 password: "foobar",
						 password_confirmation: "foobar")

99.times do |n|
	name = Faker::Name.name
	email = Faker::Internet.safe_email
	role = ["recruiter", "job-seeker"]
	User.create!(name: name,
							 email: email,
							 role: role[n%2],
							 password: "foobar",
							 password_confirmation: "foobar")
end



Job.create!(title:"AI with Avengers",
						description: "We have an urgent vacancy of a programmer who can fix Vision's mind-stone. 
						              The qualified candidate gets a chance to work with Dr. Banner and Mr. Stark.
						              The candidate also gets an opportunity to become a part of Team Avengers. Interested
						              candidates please apply at the given Link. Thanks, Team Avengers.",
            sector: "Artificial Intelligence",
            jobtype: "Development",
            cname: "Avengers",
            url: "http://wakanda.avengers.org/",
            contactmail: "blackwidow@avengers.com",
            location: "Wakanda",
            user_id: 2)

Job.create!(title:"Associate System Developer",
						description: "An opportunity to work with one of the world's leading technology companies.
						  Amongst a plethora of recognitions, Kreeti is #2 in Fortune's most admired computer
						  companies, and recently rated as the happiest company for young professionals - By Forbes 
              Under the GSAP program, you are assured of a world class mentoring program to help you be
              successful in the long run. ",
            sector: "IT",
            jobtype: "Development",
            cname: "Kreeti Technologies",
            url: "http://careers.kreeti.com/",
            contactmail: "careers@kreeti.com",
            location: "Kolkata",
            user_id: 4)

i=2
50.times do |n|
	title = ["Software Developer", "AI", "Mechanical Enginner", "Graphics Designer", "Nurse", "Accountant",
	         "Manager", "System Developer", "Associate Engineer"]
	description = Faker::Lorem.paragraph
	sector = ["IT", "Manufacturing", "Core", "Other",	"Banking" ]
	jobtype = ["Design", "Development", "Receptionist", "Management", "Medical Representative", "Other"]
	cname = Faker::Company.name
	url = Faker::Internet.url
	contactmail = Faker::Internet.safe_email
	location = Faker::Address.city
	Job.create!(title: title[n%9],
							description: description,
							sector: sector[n%5],
							jobtype: jobtype[n%6],
							cname: cname,
							url: url,
							contactmail: contactmail,
							location: location,
							user_id: i )
	i+=2

end