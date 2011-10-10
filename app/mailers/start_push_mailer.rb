class StartPushMailer < ActionMailer::Base
  default :from => "admin@pushsurvey.com"

  def start(push)
    @push = push
    @url  = "http://www.pushsurvey.com"
    @push.address_book.contacts.each do |contact|
      @user = contact
      mail(:to => contact.email, :subject => push.name)
    end
  end
end
