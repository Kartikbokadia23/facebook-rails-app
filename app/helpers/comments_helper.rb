module CommentsHelper
    def find_comments(post)
      comments = Comment.includes(:user).where(post_id: post.id)
      comments
    end
  end