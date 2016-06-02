class NotificationController < ApplicationController
  def send_push
    app_name = ENV["APN_NAME"]

    notification = Rpush::Apns::Notification.new
    notification.app = Rpush::Apns::App.find_by_name(app_name)
    notification.device_token = ENV["DEVICE_TOKEN"]
    notification.alert = "hi mom!"
    notification.data = { foo: :bar }
    notification.save!

    render :complete
  end

  def complete
  end
end
