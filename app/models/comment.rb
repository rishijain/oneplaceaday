class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def send_notification
    CommentMailer.new_comment_notification(self).deliver_later
  end
end
