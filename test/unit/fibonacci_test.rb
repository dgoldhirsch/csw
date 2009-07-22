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

  should "valid options for initialization" do
    fib = Fibonacci.new
  end

  should "respond to #new_record? with true" do
    assert Fibonacci.new.new_record?
  end

  should "respond to #id with nil" do
    assert_nil Fibonacci.new.id
  end

  should "return 0 for non-numeric n" do
    assert_equal 0, Fibonacci.new(:n=> 'a').result
    assert_equal 0, Fibonacci.new(:n=> '  ').result
  end

  should "raise ActiveRecord::RecordNotFound if n is nil on #result" do
    assert_raise(ActiveRecord::RecordNotFound) do
      Fibonacci.new(:n => nil).result
    end
  end

  should "call CS::fibonacci and get result" do
    n = 5
    algorithm = 'matrix'

    CS.stubs(:fibonacci).returns(5)
    Fibonacci.new(:n => n, :algorithm => algorithm).result

    assert_received(CS, :fibonacci) do |expects|
      expects.with(n, algorithm.to_sym)
    end
  end

  should "nil algorithm" do
    n = 6

    CS.stubs(:fibonacci).returns(8)
    Fibonacci.new(:n => n, :algorithm => nil).result

    assert_received(CS, :fibonacci) do |expects|
      expects.with(n)
    end
  end

  should "blank algorithm" do
    n = 6

    CS.stubs(:fibonacci).returns(8)
    Fibonacci.new(:n => n, :algorithm => '').result

    assert_received(CS, :fibonacci) do |expects|

      expects.with(n)
    end
  end
end
