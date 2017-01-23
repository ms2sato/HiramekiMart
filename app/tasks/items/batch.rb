class Items::Batch
  def self.job
    Rails.application.config.batch_logger.info ("start バッチ処理")
    Item.change_to_give_up_if_limited
    Item.change_to_success do |item|
      PostMailer.post_email_owner(item).deliver
      PostMailer.post_email_costmer(item).deliver
    end
    Rails.application.config.batch_logger.info ("end バッチ処理")
  end
end
