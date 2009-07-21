require 'test_helper'

class FibonacciControllerTest < ActionController::TestCase
  context "new" do
    setup do
      get :new
    end
    should_render_template :new
    should "new form" do
      assert_response :success
      verify_form_for "", :selected => 'matrix', :other => 'addition'
    end
  end

  context "compute matrix" do
    setup do
      post :compute, :n => 6, :algorithm => "matrix"
    end

    # Instance variables in controller
    should_assign_to :matrix_checked
    should_not_assign_to :addition_checked
    should "assignments" do
      assert_equal "6", assigns(:n)
      assert_equal :matrix, assigns(:algorithm_name)
      assert_equal 8, assigns(:result)
    end

    # Response
    should_render_template :compute
    should "respond using matrix" do
      assert_response :success
      verify_form_for "6", :selected => 'matrix', :other => 'addition'
      verify_result "8"
    end
  end

  context "compute addition" do
    setup do
      post :compute, :n => 6, :algorithm => "addition"
    end

    #Instance variables in controller
    should_not_assign_to :matrix_checked
    should_assign_to :addition_checked
    should "assignments" do
      assert_equal "6", assigns(:n)
      assert_equal :addition, assigns(:algorithm_name)
      assert_equal 8, assigns(:result)
    end

    # Response
    should_render_template :compute
    should "respond using addition" do
      assert_response :success
      verify_form_for 6, :selected => 'addition', :other => 'matrix'
      verify_result "8"
    end
  end

  context "bad parameters" do
    should "get errors" do
      post :compute, :n => "asdf", :algorithm => "fubar"
      verify_result "Unknown algorithm " + "fubar" + " ignored"
    end
  end

  protected
  
  # Private.
  # Verify response contains a form with an input for n and
  # an input for the algorithm to be used
  def verify_form_for n, algorithm_options
    assert_select "form[method=post]" do
      assert_select "input", 4 # includes hidden <input id='authenticity_token'>
      assert_select "input[name=n][value=#{n}]", 1  # one input for n = ""
      assert_select "input[id=authenticity_token]", 1
      verify_algorithm_input algorithm_options
    end
  end

  # Private.
  # Verify response contains an algorithm input with
  # one option selected
  def verify_algorithm_input options
    assert_select "input[name=algorithm]", 2 do | tags |
      selected_tag = tags.detect {|t| t.attributes['value'] == options[:selected]}
      assert selected_tag
      selected_tag.attributes['checked']
      other_tag = tags.detect {|t| t.attributes['value'] == options[:other]}
      assert other_tag
      assert !(other_tag.attributes['checked'])
    end
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

