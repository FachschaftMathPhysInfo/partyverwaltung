j = Judge.new(:controller => "JudgesController", :method => "init", :level => 0)
j.save

p = Party.new(:jahr => "1337", :semester => "Winter", :active => true)
p.save

JudgesController.new.init
