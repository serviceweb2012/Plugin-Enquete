class Aswer < ActiveRecord::Base
  belongs_to :question
  attr_accessor :should_destroy

  def should_destroy?
    should_destroy.to_i == 1
  end
end