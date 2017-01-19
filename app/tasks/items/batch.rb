class Items::Batch
  def self.job
    Rails.application.config.batch_logger.info ("start バッチ処理")
    Item.change_to_give_up_if_limited
    Item.change_to_success
    Rails.application.config.batch_logger.info ("end バッチ処理")
  end
end
