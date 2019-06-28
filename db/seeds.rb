natasha = User.create(name: 'Natasha', email: 'natasha@email.com', password: 'pass1')
brian = User.create(name: 'Brian', email: 'brian@email.com', password: 'pass2')
jessica = User.create(name: 'Jessica', email: 'jessica@email.com', password: 'pass3')

starbucks = Roaster.create(name: 'Starbucks')
peets = Roaster.create(name: 'Peets Coffee')
philz = Roaster.create(name: 'Philz Coffee')

pike_place = Coffee.create(name: 'Pike Place', roast: 'medium', roaster: starbucks)
big_bang = Coffee.create(name: 'Big Bang', roast: 'medium', roaster: peets)
silken_splendor = Coffee.create(name: 'Silken Splendor', roast: 'medium', roaster: philz)

natasha.cups.create(brew: 'cold brew', coffee: silken_splendor)
brian.cups.create(brew: 'iced latte', coffee: pike_place)
jessica.cups.create(brew: 'drip', coffee: big_bang)
natasha.cups.create(brew: 'cold brew', coffee: big_bang)
brian.cups.create(brew: 'iced coffee', coffee: pike_place)
jessica.cups.create(brew: 'drip', coffee: pike_place)