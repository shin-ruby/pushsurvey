# -*- encoding : utf-8 -*-
class AddressBook < ActiveRecord::Base
  acts_as_audited
  scope :active, where(:step=>nil)
  include UserResource

  has_many :contacts,:dependent => :destroy


  attr_accessor :disable_validation

  validates_presence_of :name, :if => lambda { |o| o.step == "name" && !disable_validation }

  mount_uploader :import_file, ImporterUploader

  def steps

     ["name", "agree_provision"]
  end

  def next_step
    self.step = steps[steps.index(self.step)+1]
  end

  def previous_step
    self.step = steps[steps.index(self.step)-1]
  end


end
