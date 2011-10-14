class PushMailer < ActionMailer::Base
  default :from => "admin@pushsurvey.com"

  def start(contact, push)
    @url = "http://www.pushsurvey.com"
    @push = push
    @from = @push.from_email || "admin@pushsurvey.com"
    @user = contact
    headers["X-SMTPAPI"] = "{\"category\": \"push-#{@push.id}\"}"
    attachments.inline['logo.png'] = File.open('public/images/logo.png', "rb").read
    attachments.inline['y.gif'] = File.open('public/images/y.gif', "rb").read
    options = {:to => contact.email, :from=>@from}
    options[:reply_to] = @push.reply_to_email if @push.reply_to_email.present?

    options[:subject] = push.subject || push.name
    mail(options)

  end
end
