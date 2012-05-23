class CustomerEnquete < ActiveRecord::Base
  
  belongs_to :question
  
  validates_presence_of :name, :phone, :email
  validates_uniqueness_of :email, :scope => :question_id
  
  named_scope :actived?, :conditions => { :situation => true }
end