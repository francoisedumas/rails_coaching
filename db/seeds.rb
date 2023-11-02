puts "Starting the seeds!"

10.times do
  Quote.create(name: Faker::Quote.most_interesting_man_in_the_world)
end

puts "Seeds generated successfully."
