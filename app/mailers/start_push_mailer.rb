class StartPushMailer < ActionMailer::Base
  default :from => "admin@pushsurvey.com"

  def start(contact, push)
    @url  = "http://www.pushsurvey.com"
    @push = push
    @user = contact
    headers["X-SMTPAPI"] = "{\"category\": \"push-#{@push.id}\"}"
     attachments.inline['logo.png'] = File.open('public/images/logo.png', "rb").read
    attachments.inline['y.gif'] = File.open('public/images/y.gif', "rb").read
      mail(:to => contact.email, :subject => push.name)

  end
end
