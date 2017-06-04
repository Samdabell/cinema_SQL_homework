require_relative '../db/sql_runner'

class Customer

  attr_accessor :id, :name, :funds

  def initialize(options)
    @id = options['id'].to_i() if options['id'] 
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', '#{@funds}') RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i()
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', '#{@funds}') WHERE id = #{@id} ;"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = #{@id} ;"
    SqlRunner.run(sql)
  end

  def films
    sql = "SELECT * FROM tickets WHERE customer_id = #{@id}"
    tickets = SqlRunner.run(sql)
    tickets.map { |ticket_hash| Ticket.new(ticket_hash).film}
  end

  def ticket_check
    return films.count
  end

  def self.all
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    return customers.map { |customer_hash| Customer.new(customer_hash)}
  end

  def self.delete_all
    sql = "DELETE FROM customers ;"
    SqlRunner.run(sql)
  end

end