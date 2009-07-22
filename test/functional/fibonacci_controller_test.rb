require 'test_helper'

class FibonacciControllerTest < ActionController::TestCase
  context "new" do
    setup do
      get :new
    end

    should_render_template :new
    should_assign_to :fibonacci

    should "new form" do
      assert_response :success
      verify_new_view
    end

    should "assign a new fibonacci to @fibonacci" do
      assert_respond_to assigns(:fibonacci), :result
    end
  end

  context "compute matrix" do
    setup do
      post :compute, :fibonacci => {:n => '6', :algorithm => "matrix"}
    end

    should "assign to @fibonacci a new Fibonacci object with the values set" do
      assert_not_nil assigns(:fibonacci)
      assert_equal '6', assigns(:fibonacci).n
      assert_equal 'matrix', assigns(:fibonacci).algorithm
    end

    # Response
    should_render_template :compute

    should "respond using matrix" do
      assert_response :success
      verify_matrix_compute_view_for "6"
      verify_result "8"
    end
  end

  context "compute addition" do
    setup do
      post :compute, :fibonacci => {:n => '6', :algorithm => "addition"}
    end

    should "assign to @fibonacci a new Fibonacci object with the values set" do
      assert_not_nil assigns(:fibonacci)
      assert_equal '6', assigns(:fibonacci).n
      assert_equal 'addition', assigns(:fibonacci).algorithm
    end

    # Response
    should_render_template :compute

    should "respond using addition" do
      assert_response :success
      verify_addition_compute_view_for "6"
      verify_result "8"
    end
  end

  context "bad parameters" do
    should "get errors" do
      post :compute, :fibonacci => {:n => "asdf", :algorithm => "fubar"}
      verify_result "Unknown algorithm " + "fubar" + " ignored"
    end
  end

  protected
  
  def verify_addition_compute_view_for n
    assert_select "form[method=post]" do | fs |
      self.verify_compute_view_for n
      self.verify_addition_algorithm_input
    end
  end

  def verify_matrix_compute_view_for n
    assert_select "form[method=post]" do | fs |
      self.verify_compute_view_for n
      self.verify_matrix_algorithm_input
    end
  end

  def verify_new_view
    assert_select "form[method=post]" do |fs|
      assert_select "input", 5 # includes hidden <input id='authenticity_token'>
      assert_select "input[id=fibonacci_n]", 1  # one input for n...
      assert_select "input[id=fibonacci_n][value]", 0  # having no preset value
      assert_select "input[id=authenticity_token]", 1
    end
  end
  
  def verify_compute_view_for n
      assert_select "input", 5 # includes hidden <input id='authenticity_token'>
      assert_select "input[id=fibonacci_n][value=#{n}]", 1  # one input for n = ""
      assert_select "input[id=authenticity_token]", 1
  end
  
  def verify_addition_algorithm_input
    assert_select "input[id=fibonacci_algorithm_addition][checked=checked]", 1
    assert_select "input[id=fibonacci_algorithm_matrix][checked=checked]", 0
    assert_select "input[id=fibonacci_algorithm_matrix]", 1
  end

  def verify_matrix_algorithm_input
    assert_select "input[id=fibonacci_algorithm_matrix][checked=checked]", 1
    assert_select "input[id=fibonacci_algorithm_addition][checked=checked]", 0
    assert_select "input[id=fibonacci_algorithm_addition]", 1
  end

  def verify_result text
    assert_select "div[id=result]", 1, :text => text
  end
end


#context "GET to show" do
#  setup do
#    get :show, :id => '6'
#  end
#  should "show the answer" do
#    assert_select 'p', '8'
#  end
#  should "show the form" do
#    assert_select 'form[action=?][method=post]', fibonaccis_path
#  end
#end
#
#context "GET to new" do
#  setup do
#    get :new
#  end
#  should "show the form" do
#    assert_select 'form[action=?][method=post]', fibonaccis_path
#  end
#end
#
#context "POST to create" do
#  setup do
#    post :create, :n => '6', :algorithm => 'matrix'
#  end
#  should_redirect_to('the show page') do
#    fibonacci_path(6, :algorithm => 'matrix')
#  end
#end

