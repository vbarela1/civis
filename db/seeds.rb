user = User.create(
  email: 'test@test.com',
  password: 'password',
  first_name: 'Valerie',
  last_name: 'Barela',
)

puts 'Test user created.'

file = File.read('lib/senate.json')
parsed = JSON.parse(file)
members = parsed["members"]
members.each do |mem|
  rep = Rep.create(
    first_name: mem["first_name"],
    last_name: mem["last_name"],
    state: mem["state"],
    title: "Senator",
    party: mem["party"],
    phone: mem["phone"],
    url: mem["url"],
    next_election: mem["next_election"],
    twitter_account: mem["twitter_account"]
  )
end

puts 'Senators created'

file = File.read('lib/house.json')
parsed = JSON.parse(file)
members = parsed["members"]
members.each do |mem|
  rep = Rep.create(
    first_name: mem["first_name"],
    last_name: mem["last_name"],
    state: mem["state"],
    title: "Representative",
    party: mem["party"],
    phone: mem["phone"],
    url: mem["url"],
    next_election: mem["next_election"],
    twitter_account: mem["twitter_account"],
    district: mem["district"]
  )
end

puts "House Rep Created"


user.create_ties("84103")

puts 'Ties created.'
