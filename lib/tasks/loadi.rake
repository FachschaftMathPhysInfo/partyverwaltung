require 'csv' 

task :loadi => :environment do
  #Dir.foreach(File.join(Rails.root,"csvs")) do |item|
  ['people.csv', 'parties.csv', 'councils.csv', 'sections.csv', 'notes.csv', 'rights.csv', 'section_managers.csv', 'shifts.csv'].each do |item|
    next if item == '.' or item == '..'

    name = File.basename(item.to_s, ".csv")
    
    csv_text = File.read("csvs/"+item.to_s)
    csv = CSV.parse(csv_text, :headers => true)
    
    puts "Controller"
    puts name.camelize.singularize
    csv.each do |row|
      next if row.to_hash["id"].start_with?('(')
      name.camelize.singularize.constantize.create(row.to_hash)
      if name.camelize.singularize == "Person"
        Status.create(:person_id => row.to_hash["id"] , :value => 0)
      end
    end
  end
end
