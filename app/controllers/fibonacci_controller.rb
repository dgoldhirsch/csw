require 'cs'

class FibonacciController < ApplicationController
  #GET /fibonacci/new
  #
  # Return a form to invoke CS::fibonacci whose action is :compute
  #
  # Optional parameters:
  #  n an integer (negative values are interpreted as 0)
  #  algorithm one of these strings ('CS::MATRIX', 'CS::ADDITION'), whose default is 'CS::MATRIX'
  def new
    @fibonacci = Fibonacci.new
    #respond_to do |f|
    #  f.html
    #end
  end

  #POST /fibonacci/n?algorithm={MATRIX, ADDITION}
  #
  # Call CS::fibonacci with the given n and algorithm.
  # Return another compute form with those values, as well as the result.
  # The result will be a simple integer, or will be a string in case of
  # error.
  #
  # ASSUMPTION:  Rails is configured to prevent a GET;  this method
  # will not check, and will probably work correctly with a GET (which is
  # undesirable)
  def compute
    @fibonacci = Fibonacci.new(params[:fibonacci])
    @errors = []
    @n = params[:fibonacci][:n]
    self.validate_algorithm
    if !(@errors.empty?)
      @result = @errors.to_s
    else
      @result = @fibonacci.result
    end

    #respond_to do |f|
    #  f.html
    #end
  end

  protected
  
  #Ensure that algorithm parameter has a value we understand.
  #If so, set instance variables used by view.  If not, set an error.
  def validate_algorithm
    if params[:fibonacci][:algorithm] == "addition"
      @algorithm_name = :addition
      @addition_checked = "CHECKED"
    else # assume matrix radio button, but return error if something else
      @algorithm_name = :matrix
      @matrix_checked = "CHECKED"
      if params[:fibonacci][:algorithm] != "matrix"
        @errors << "Unknown algorithm #{params[:fibonacci][:algorithm]} ignored"
      end
    end
  end
end
