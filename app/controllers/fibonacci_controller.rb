require 'cs'

class FibonacciController < ApplicationController
  # GET /fibonacci
  # GET /fibonacci.xml
  # Optional parameters:
  #   n an integer (negative values are interpreted as 0)
  #   algorithm one of these strings ('CS::MATRIX', 'CS::ADDITION'), whose default is 'CS::MATRIX'
  def show
    @algorithm = params[:algorithm]
    self.set_algorithm_variables
    @n = params[:n]
    if(@n)
      self.set_result_variables
    end
    respond_to do |f|
      f.html
    end
  end

  def set_algorithm_variables
    if(@algorithm == "addition")
      @algorithm_name = :addition
      @addition_checked = "CHECKED"
    else
      @algorithm_name = :matrix
      @matrix_checked = "CHECKED"
    end
  end

  def set_result_variables
    puts "@algorithm " + @algorithm
    puts "@n.to_i " + @n.to_i.to_s
    @result = CS::fibonacci(@n.to_i, @algorithm_name)
    puts "@result " + @result.to_s
  end

end
