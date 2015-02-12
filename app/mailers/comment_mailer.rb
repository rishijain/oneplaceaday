class CommentMailer < ApplicationMailer

  def new_comment_notification(comment)
    @commenter = comment.user_id.nil? ? "An anonymous user" : comment.user.username
    @post = comment.post
    @author = @post.user
    mail(to: @author.email, subject: 'New comment on your post at happyplace')
  end

end
