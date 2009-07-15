require File.dirname(__FILE__) + '/../test_helper'

class TagTest < Test::Unit::TestCase
  should_have_many :taggings, :dependent => :destroy
  should_have_many :posts

  should_ensure_length_at_least :name, 2

  should_protect_attributes :secret
  should_allow_mass_assignment_of :name

  should_fail do
    should_not_allow_mass_assignment_of :name
  end
end
