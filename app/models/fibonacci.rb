class Fibonacci

  MATRIX = 'matrix'
  ADDITION = 'addition'

  attr_accessor :n
  attr_accessor :algorithm

  def initialize(options={})
    options.each do |key, value|
      self.send("#{key}=", value)
    end
    self.algorithm = MATRIX if self.algorithm.nil? || self.algorithm.blank? # nil or blank 
  end

  def new_record?
    return true
  end

  def id
    return nil
  end

  def matrix?
    return self.algorithm == MATRIX
  end
  
  def result
    if self.n.nil?
      raise ActiveRecord::RecordNotFound.new
    elsif n.to_i.zero?
      0
    else
      CS::fibonacci(self.n.to_i, self.algorithm.to_sym)
    end
  end
  
  def to_s
    'n => ' + self.n.to_s + ', algorithm => ' + self.algorithm.to_s
  end
end
