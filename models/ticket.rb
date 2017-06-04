require_relative '../db/sql_runner'

class Ticket

  attr_accessor :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i() if options['id'] 
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ('#{@customer_id}', '#{@film_id}') RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i()
  end

  def update
    sql = "UPDATE tickets SET (customer_id, film_id) = ('#{@customer_id}', '#{@film_id}') WHERE id = #{@id} ;"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = #{@id} ;"
    SqlRunner.run(sql)
  end

  def customer
    sql = "SELECT * FROM customers WHERE id = #{@customer_id};"
    customers = SqlRunner.run(sql)
    return customers.map { |customer_hash| Customer.new(customer_hash)}
  end

  def film
    sql = "SELECT * FROM films WHERE id = #{@film_id};"
    films = SqlRunner.run(sql)
    return films.map { |film_hash| Film.new(film_hash)}
  end

  def self.all
    sql = "SELECT * FROM tickets;"
    tickets = SqlRunner.run(sql)
    return tickets.map { |ticket_hash| Ticket.new(ticket_hash)}
  end

  def self.delete_all
    sql = "DELETE FROM tickets ;"
    SqlRunner.run(sql)
  end

end