require 'test_helper'

class CswControllerTest < ActionController::TestCase
  context "csw basic" do
    setup do
      @n = 1
    end

    should "trivial test work" do
      assert_equal 1, @n
    end
  end
end
