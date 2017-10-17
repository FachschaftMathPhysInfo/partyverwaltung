task :init => :environment do
  Judge.create(:controller => "JudgesController", :method => "init", :level => 0)
  Right.create(:nick => "unknown", :level => "-1")
  #Party.create(:jahr => "1337", :semester => "Winter", :active => true)

  JudgesController.new.init
end
