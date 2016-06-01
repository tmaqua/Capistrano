class MailController < ApplicationController
  def send_mail
    TestMailer.post_email().deliver_later
    render :complete
  end

  def complete
  end
end
