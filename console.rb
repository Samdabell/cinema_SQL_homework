require 'pry-byebug'
require_relative 'models/customer'
require_relative 'models/film'
require_relative 'models/ticket'

customer1 = Customer.new({
  'name' => 'Sam',
  'funds' => 50
  })

customer2 = Customer.new({
  'name' => 'Freyja',
  'funds' => 350
  })

customer1.save()
customer2.save()

film1 = Film.new({
  'title' => 'The Room',
  'price' => 5
  })

film2 = Film.new({
  'title' => 'Toy Story',
  'price' => 10
  })

film1.save()
film2.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })

ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })

ticket1.save()
ticket2.save()
ticket3.save()

binding.pry
nil