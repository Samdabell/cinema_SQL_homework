require_relative '../db/sql_runner'

class Film

  attr_accessor :id, :title, :price

  def initialize(options)
    @id = options['id'].to_i() if options['id'] 
    @title = options['title']
    @price = options['price'].to_i
  end

  def save
    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', '#{@price}') RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i()
  end

  def update
    sql = "UPDATE films SET (title, price) = ('#{@title}', '#{@price}') WHERE id = #{@id} ;"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM films WHERE id = #{@id} ;"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT * FROM tickets WHERE film_id = #{@id}"
    tickets = SqlRunner.run(sql)
    tickets.map { |ticket_hash| Ticket.new(ticket_hash).customer}
  end

  def customer_check
    return customers.count
  end

  def self.all
    sql = "SELECT * FROM films;"
    films = SqlRunner.run(sql)
    return films.map { |film_hash| Film.new(film_hash)}    
  end

  def self.delete_all
    sql = "DELETE FROM films ;"
    SqlRunner.run(sql)
  end

end