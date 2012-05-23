class Question < ActiveRecord::Base
  has_many :aswers, :dependent => :destroy
  
    has_many :customer_enquente
  
  validates_presence_of :name
   named_scope :actived?, :conditions => { :situation => true }
   
  def aswer_attributes=(aswer_attributes)
    aswer_attributes.each do |attributes|
      if attributes[:id].blank?
        if !attributes[:name].blank?
          aswers.build(attributes)
        end
      else
        aswer = aswers.detect { |t| t.id== attributes[:id].to_i }
        if aswer.id.blank? && attributes[:name].blank?
          aswer.destroy
        else
          aswer.attributes = attributes
        end
      end
    end
  end

  def save_aswers
    aswers.each do |c|
      if c.should_destroy?
        c.destroy
      else
        c.save(false)
      end
    end
  end
end