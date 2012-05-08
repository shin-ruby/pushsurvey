# -*- encoding : utf-8 -*-
class Push < ActiveRecord::Base
  acts_as_audited

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

  validates_format_of :from_email,:with => EMAIL_REGEX, :if => lambda { |o| o.step == "add_email_title" && !disable_validation && from_email.present?}
  validates_format_of :reply_to_email,:with => EMAIL_REGEX, :if => lambda { |o| o.step == "add_email_title" && !disable_validation && reply_to_email.present? }

  def steps

     ["name", "choose_category", "choose_address_book", "add_email_title"]
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

  def start
    require 'address_book'
    require 'push_mailer'

    address_book.contacts.each do |contact|
      PushMailer.start(contact, self).deliver
    end


    PushMailer.start_result(self.user).deliver

    self.status = "Send"
    self.save
  end
  #for DJ support
  def perform
    start
  end
end
