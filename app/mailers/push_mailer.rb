class PushMailer < ActionMailer::Base
  default :from => "admin@pushsurvey.com"

  def start(contact, push)
    @url = "http://www.pushsurvey.com"
    @push = push
    @from = push.from_email.present? && push.from_email.strip.present? ? push.from_email.strip : "admin@pushsurvey.com"
    @user = contact
    headers["X-SMTPAPI"] = "{\"category\": \"push-#{@push.id}\"}"
    attachments.inline['logo.png'] = File.open('public/images/logo.png', "rb").read
    attachments.inline['y.gif'] = File.open('public/images/y.gif', "rb").read
    options = {:to => contact.email, :from=>@from}
    options[:reply_to] = @push.reply_to_email if @push.reply_to_email.present? && @push.reply_to_email.strip.present?

    options[:subject] = push.subject.present? && push.subject.strip.present? ? push.subject.strip : push.name
    mail(options)

  end
end
