class StartPushMailer < ActionMailer::Base
  default :from => "admin@pushsurvey.com"

  def start(contact, push)
    @url  = "http://www.pushsurvey.com"
    @push = push
    @user = contact
      mail(:to => contact.email, :subject => push.name)

  end
end
