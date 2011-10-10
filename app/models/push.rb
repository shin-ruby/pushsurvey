class Push < ActiveRecord::Base
  scope :active, where(:step=>nil)
  include UserResource




  belongs_to :category
  belongs_to :folder

  belongs_to :design
  belongs_to :address_book


  attr_accessor :disable_validation

  validates_presence_of :name, :if => lambda { |o| o.step == "name" && !disable_validation }


  validates_presence_of :category_id, :if => lambda { |o| o.step == "choose_category" && !disable_validation }
  validates_presence_of :folder_id, :if => lambda { |o| o.step == "choose_category" && !disable_validation }


  validates_presence_of :address_book, :if => lambda { |o| o.step == "choose_address_book" && !disable_validation }
  validates_presence_of :design, :if => lambda { |o| o.step == "choose_address_book" && !disable_validation }

  def steps

     ["name", "choose_category", "choose_address_book"]
  end

  def next_step
    self.step = steps[steps.index(self.step)+1]
  end

  def previous_step
    self.step = steps[steps.index(self.step)-1]
  end


  def date_push_presenter
    if date_push
      result = date_push
    else
      result = "Pending"
    end
  end

  def feedback_presenter
    feedback ||= 0.0
    (feedback * 100).to_s + "%"
  end
end
