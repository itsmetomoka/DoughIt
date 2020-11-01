module NotificationsHelper

	def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    your_lesson = link_to 'あなたの投稿', lesson_path(notification), style:"font-weight: bold;"
    @visitor_comment = notification.comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "favorite" then
        tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたのレッスン', href:lesson_path(notification.lesson_id), style:"font-weight: bold;")+"にいいねしました"
      when "reservation" then
        tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたのレッスン', href:lesson_path(notification.lesson_id), style:"font-weight: bold;")+"を予約しました"
      when "comment" then
          @comment = Comment.find_by(id: @visitor_comment)&.comment
          tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたのレッスン', href:lesson_path(notification.lesson_id), style:"font-weight: bold;")+"にコメントしました"
      when "review" then
        tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+ "があなたのレビューを書きました"
    end
  end

end
