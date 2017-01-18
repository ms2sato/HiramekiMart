class Tasks::Batch
  def self.job
    Item.change_to_give_up
    Item.change_to_success
  end
end
