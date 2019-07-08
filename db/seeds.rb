starbucks = Roaster.new(name: 'Starbucks')
peets = Roaster.new(name: 'Peets Coffee')
philz = Roaster.new(name: 'Philz Coffee')

pike_place = Coffee.new(name: 'Pike Place', roast: 'medium', roaster: starbucks)
big_bang = Coffee.new(name: 'Big Bang', roast: 'medium', roaster: peets)
silken_splendor = Coffee.new(name: 'Silken Splendor', roast: 'medium', roaster: philz)

natasha = User.create(name: 'Natasha', email: 'natasha@email.com', password: 'pass1')
brian = User.create(name: 'Brian', email: 'brian@email.com', password: 'pass2')
jessica = User.create(name: 'Jessica', email: 'jessica@email.com', password: 'pass3')

cup1 = natasha.cups.build(brew: 'cold brew', coffee: silken_splendor)
cup2 = brian.cups.build(brew: 'iced latte', coffee: pike_place)
cup3 = jessica.cups.build(brew: 'drip', coffee: big_bang)
cup4 = natasha.cups.build(brew: 'cold brew', coffee: big_bang)
cup5 = brian.cups.build(brew: 'iced coffee', coffee: pike_place)
cup6 = jessica.cups.build(brew: 'drip', coffee: pike_place)

cup1.save
cup2.save
cup3.save
cup4.save
cup5.save
cup6.save