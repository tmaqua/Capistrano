class TestMailer < ApplicationMailer
  def post_email
    to = ENV["MAIL_ADDRESS_TO"]
    from = ENV["MAIL_ADDRESS_FROM"]
    subject = "Send from fankami.com"
    mail to: to, from: from, subject: subject
  end
end
