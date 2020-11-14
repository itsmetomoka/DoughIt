class Batch::EditLessons
  def self.edit_lessons
    # 投稿を全て削除
    lessons = Lesson.all
    # 時刻を日本時間に戻す
    now = Time.zone.now
    lessons.each do |lesson|
      if lesson.max_attendees <= lesson.reservations.count || lesson.deadline < now
        lesson.is_active = false
        # 強制的にfalseに変える
        lesson.save!(validate: false)
        p "予約不可能なレッスンを削除しました。"
      end
    end
  end
end
