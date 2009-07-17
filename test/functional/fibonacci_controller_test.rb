require 'test_helper'

class FibonacciControllerTest < ActionController::TestCase
  context "new" do
    setup do
      get :new
    end
    should_render_template :new
  end

  context "compute matrix" do
    setup do
      get :compute, :n => 6, :algorithm => "matrix"
    end
    should_assign_to :matrix_checked
    should_not_assign_to :addition_checked
    should "assignments" do
      assert_equal "6", assigns(:n)
      assert_equal :matrix, assigns(:algorithm_name)
      assert_equal 8, assigns(:result)
    end
    should_render_template :compute
  end

  context "compute addition" do
    setup do
      get :compute, :n => 6, :algorithm => "addition"
    end
    should_not_assign_to :matrix_checked
    should_assign_to :addition_checked
    should "assignments" do
      assert_equal "6", assigns(:n)
      assert_equal :addition, assigns(:algorithm_name)
      assert_equal 8, assigns(:result)
    end
    should_render_template :compute
  end

  #context "Must be POST" do
  #  setup do
  #    get :compute, :n => 6, :algorithm => "matrix"
  #  end
  #
  #  should "fail because of method" do
  #    # TODO: ensure response is error of GET rather than POST
  #  end
  #end

  context "bad parameters" do
    setup do
      get :compute, :n => "asdf", :algorithm => "fubar"
    end

    should "get errors" do
      # TODO: ensure response contains two error messages, one for n, the other for algorithm
    end
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

