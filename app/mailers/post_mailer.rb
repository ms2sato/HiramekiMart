class PostMailer < ApplicationMailer
  default from: "from@example.com"

  def post_email_owner(item)
    @item = item.name
    mail to: item.user.email, subject: "おめでとうございます。"
  end

  def post_email_costmer(item)
    supporters = item.supporters.uniq
    supporters.each do |suppoter|
      @item = item.name
      mail to: suppoter.email, subject: "おめでとうございます。"
    end
  end
end
