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

  # GET /fibonacci/:n?algorithm={MATRIX, ADDITION}
  # TODO: Change to POST, because (dimly, theoretically) the computation could have a side-effect within the server.
  def compute
    @errors = []
    @n = params[:n]
    self.validate

    if !(@errors.empty?)
      @result = @errors.to_s
    elsif
      @result = CS::fibonacci(@n.to_i, @algorithm_name)
    end

    respond_to do |f|
      f.html
    end
  end

  def validate
    #self.validate_post_method  # TODO: Ensure it's truly a POST
    self.validate_algorithm
  end

  def validate_post_method
    @errors << "fibonacci/compute method " + request.method.to_s + " should be POST" if !(request.post?)
  end

  def validate_algorithm
    if params[:algorithm] == "addition"
      @algorithm_name = :addition
      @addition_checked = "CHECKED"
    else # assume matrix radio button, but return error if something else
      @algorithm_name = :matrix
      @matrix_checked = "CHECKED"
      if params[:algorithm] != "matrix"
        @errors << "Unknown algorithm " + params[:algorithm] + " ignored"
      end
    end
  end
end
