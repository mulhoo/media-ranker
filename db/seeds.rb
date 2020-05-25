require 'csv'

MEDIA_FILE = Rails.root.join('db','works-seeds.csv')
puts "Loading data from #{MEDIA_FILE}"

failures = []

CSV.foreach(MEDIA_FILE, headers: true) do |row|
  work = Work.new

  work.title = row['title']
  work.category  = row['category']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']

  successful = work.save
  if !successful
    failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{failures.length} works failed to save"