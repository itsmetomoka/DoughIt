class Batch::EditLessons
  def self.edit_lessons
    # 投稿を全て削除
    lessons = Lesson.all

    lessons.each do |lesson|
      if lesson.max_attendees <= lesson.reservations.count || lesson.deadline < DateTime.now
        lesson.update(is_active: false)
        p "予約不可能なレッスンを削除しました。"
      end
    end
  end
end
