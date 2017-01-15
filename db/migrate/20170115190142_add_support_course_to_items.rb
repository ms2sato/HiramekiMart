class AddSupportCourseToItems < ActiveRecord::Migration
  def change
    add_column :items, :support_course, :integer, null: false, default: 0
  end
end
