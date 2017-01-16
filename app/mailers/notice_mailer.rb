class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail.subject
  #
  def sendmail(item)
    @item = item
    @greeting = "Hi"

    mail to: "to@example.org",
    subject: '【HiramekiMart】おめでとうございます！'
  end
end
