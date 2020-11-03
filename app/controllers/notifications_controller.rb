class NotificationsController < ApplicationController
 before_action :authenticate_user!
	def index
    #current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications
    #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    @notifications.where(is_checked: false).each do |notification|
      notification.update_attributes(is_checked: true)
    end
  end

  def destroy_all
    #通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_back(fallback_location: root_path)
  end

end
