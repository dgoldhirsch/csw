require 'cs'

class FibonacciController < ApplicationController
  # GET /fibonacci/new
  # Optional parameters:
  #   n an integer (negative values are interpreted as 0)
  #   algorithm one of these strings ('CS::MATRIX', 'CS::ADDITION'), whose default is 'CS::MATRIX'
  def new
    respond_to do |f|
      f.html
    end
  end

  # GET /fibonacci/:id?algorithm={MATRIX, ADDITION}
  def show
    @n = params[:n]
    self.set_algorithm_variables
    puts @algorithm_name
    @result = CS::fibonacci(@n.to_i, @algorithm_name)
    respond_to do |f|
      f.html
    end
  end

  def set_algorithm_variables
    if(params[:algorithm] == "addition")
      @algorithm_name = :addition
      @addition_checked = "CHECKED"
    else
      @algorithm_name = :matrix
      @matrix_checked = "CHECKED"
    end
  end 
end
