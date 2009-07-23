require 'test_helper'

class FibonacciTest < ActiveRecord::TestCase
  # new_record? => true
  # id => nil
  #
  # initialize takes a hash of string => string
  # n, result, algorithm
  #
  # result should raise ActiveRecord::RecordNotFound if n is nil
  # result should produce 0 if n is non-#to_i
  # result should call CS::fibonacci with n and algorithm

  should "set the accessors for the values on #new" do
    values = {'n' => '6', 'algorithm' => 'matrix'}
    fib = Fibonacci.new(values)
    values.each do |field,value|
      assert_equal value, fib.send(field)
    end
  end

  should "initialization options default to {}" do
    fib = Fibonacci.new
  end

  should "respond to #new_record? with true" do
    assert Fibonacci.new.new_record?
  end

  should "respond to #id with nil" do
    assert_nil Fibonacci.new.id
  end

  should "default initialization" do
    fib = Fibonacci.new
    puts "default initialization: " + fib.to_s
    assert fib.matrix?
    assert_nil fib.n
  end
  
  should "raise ActiveRecord::RecordNotFound if n is nil on #result" do
    assert_raise(ActiveRecord::RecordNotFound) do
      Fibonacci.new(:n => nil).result
    end
  end

  should "return 0 for non-numeric n" do
    assert_equal 0, Fibonacci.new(:n=> 'a').result
    assert_equal 0, Fibonacci.new(:n=> '  ').result
  end

  should "nil or blank algorithm" do
    fib = Fibonacci.new({'algorithm' => nil})
    assert fib.matrix?
    fib = Fibonacci.new({'algorithm' => ''})
    assert fib.matrix?
  end

  should "call CS::fibonacci and get result" do
    n = '5'
    algorithm = 'matrix'

    CS.stubs(:fibonacci).returns(5)
    Fibonacci.new(:n => n, :algorithm => algorithm).result

    assert_received(CS, :fibonacci) do |expects|
      expects.with(n.to_i, algorithm.to_sym)
    end
  end

end
