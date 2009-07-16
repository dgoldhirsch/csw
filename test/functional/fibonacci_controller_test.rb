require 'test_helper'

class FibonacciControllerTest < ActionController::TestCase
  context "New" do
    setup do
      get :new
    end
    should_render_template :new
  end

  context "GET/n?algorithm=:matrix" do
    setup do
      get :show, :n => 6, :algorithm => "matrix"
    end
    should_assign_to :matrix_checked
    should_not_assign_to :addition_checked
    should "assignments" do
      assert_equal "6", assigns(:n)
      assert_equal :matrix, assigns(:algorithm_name)
      assert_equal 8, assigns(:result)
    end
    should_render_template :show
  end
  
  context "GET/n?algorithm=:addition" do
    setup do
      get :show, :n => 6, :algorithm => "addition"
    end
    should_not_assign_to :matrix_checked
    should_assign_to :addition_checked
    should "assignments" do
      assert_equal "6", assigns(:n)
      assert_equal :addition, assigns(:algorithm_name)
      assert_equal 8, assigns(:result)
    end
    should_render_template :show
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
end
