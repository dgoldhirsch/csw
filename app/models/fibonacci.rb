class Fibonacci
  attr_accessor :n
  attr_accessor :algorithm

  def initialize(options={})
    options.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def new_record?
    return true
  end

  def id
    return nil
  end

  def result
    if self.n.nil?
      raise ActiveRecord::RecordNotFound.new
    elsif n.to_i.zero?
      0
    elsif self.algorithm.blank?
      CS::fibonacci(self.n)
    else
      CS::fibonacci(self.n, self.algorithm.to_sym)
    end
  end
end
